/*
 * ov5640_capture.c - ov5640_dma 采集 + H.265 硬编 + UDP/RTP 推流
 *
 * 打开 /dev/ov5640_dma, mmap 全部缓存, 启动采集, 收帧后推入 appsrc,
 * 经 videoconvert 转 NV12(YUV420), omxh265enc 硬编为 H.265,
 * 经 rtph265pay 打包后用 udpsink 发到目标主机。
 *
 * pipeline:
 *   appsrc(RGB) -> videoconvert -> NV12 -> omxh265enc -> h265parse
 *       -> rtph265pay(mtu=1400) -> udpsink(host:port)
 *
 * PC 接收 (gstreamer):
 *   gst-launch-1.0 udpsrc port=1234 ! application/x-rtp,media=video,
 *     clock-rate=90000,encoding-name=H265,payload=96 ! rtph265depay !
 *     h265parse ! avdec_h265 ! autovideosink
 * 或用 ffplay + sdp 文件 (见 usage 注释)。
 *
 * 编译: make CROSS_COMPILE=aarch64-linux-gnu-  (或 bitbake 环境直接 make)
 * 运行: ./ov5640_capture -i 192.168.8.214 -p 1234 -n 0
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <getopt.h>
#include <errno.h>
#include <signal.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

#include <gst/gst.h>
#include <gst/app/gstappsrc.h>

#include "ov5640_dma.h"

#define DEV_DEFAULT  "/dev/ov5640_dma"
#define HOST_DEFAULT "192.168.8.214"
#define PORT_DEFAULT 1234
#define BITRATE_KBPS 8000
#define FRAMERATE    30

/* SIGINT/SIGTERM 置位, 主循环检查后走正常清理路径,
 * 避免强杀导致 VCU 编码通道泄漏 */
static volatile sig_atomic_t g_quit;

static void on_signal(int sig)
{
	(void)sig;
	g_quit = 1;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [-d device] [-w width] [-h height] [-b bufs] [-n frames]\n"
		"          [-i dst_ip] [-p dst_port]\n"
		"  -d  device      default %s\n"
		"  -w  width       default 1280\n"
		"  -h  height      default 720\n"
		"  -b  buffers     default 3\n"
		"  -n  frames      default 0 = infinite\n"
		"  -i  dst_ip      default %s\n"
		"  -p  dst_port    default %d\n",
		prog, DEV_DEFAULT, HOST_DEFAULT, PORT_DEFAULT);
}

int main(int argc, char *argv[])
{
	const char *dev = DEV_DEFAULT;
	const char *host = HOST_DEFAULT;
	uint32_t width = 1280, height = 720, bufs = 3, frames = 0;
	int port = PORT_DEFAULT;
	struct ov5640_dma_format fmt;
	struct ov5640_dma_frame frame;
	void *map[OV_DMA_MAX_BUF] = { 0 };
	int fd, i, opt, ret = 0;
	uint32_t n;
	size_t frame_size;

	GstElement *pipeline = NULL, *appsrc;
	GstBus *bus;
	char launch[512];

	while ((opt = getopt(argc, argv, "d:w:h:b:n:i:p:")) != -1) {
		switch (opt) {
		case 'd': dev = optarg; break;
		case 'w': width = atoi(optarg); break;
		case 'h': height = atoi(optarg); break;
		case 'b': bufs = atoi(optarg); break;
		case 'n': frames = atoi(optarg); break;
		case 'i': host = optarg; break;
		case 'p': port = atoi(optarg); break;
		default:  usage(argv[0]); return 1;
		}
	}
	if (bufs < 1 || bufs > OV_DMA_MAX_BUF) {
		fprintf(stderr, "buffer count must be 1~%d\n", OV_DMA_MAX_BUF);
		return 1;
	}

	gst_init(&argc, &argv);
	signal(SIGINT, on_signal);
	signal(SIGTERM, on_signal);

	fd = open(dev, O_RDWR);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	fmt.width = width;
	fmt.height = height;
	if (ioctl(fd, OV5640_DMA_S_FMT, &fmt) < 0) {
		perror("S_FMT");
		ret = 1;
		goto out;
	}
	if (ioctl(fd, OV5640_DMA_S_BUFNUM, &bufs) < 0) {
		perror("S_BUFNUM");
		ret = 1;
		goto out;
	}
	if (ioctl(fd, OV5640_DMA_G_FMT, &fmt) < 0) {
		perror("G_FMT");
		ret = 1;
		goto out;
	}
	width = fmt.width;
	height = fmt.height;
	frame_size = (size_t)width * height * 3;
	printf("format: %u x %u, %u buffers, frame %zu bytes\n",
	       width, height, bufs, frame_size);

	/* 用 launch 串构建 pipeline, 枚举参数直接写名字:
	 * appsrc(RGB) -> videoconvert -> NV12 -> omxh265enc
	 *   -> h265parse -> rtph265pay -> udpsink */
	snprintf(launch, sizeof(launch),
		 "appsrc name=src is-live=true format=time ! "
		 "video/x-raw,format=RGB,width=%u,height=%u,framerate=%d/1 ! "
		 "videoconvert ! video/x-raw,format=NV12 ! "
		 "omxh265enc target-bitrate=%d control-rate=low-latency "
		 "gop-mode=low-delay-p periodicity-of-idr-frames=%d ! "
		 "h265parse ! rtph265pay mtu=1400 config-interval=-1 ! "
		 "udpsink host=%s port=%d async=true",
		 width, height, FRAMERATE, BITRATE_KBPS, FRAMERATE,
		 host, port);
	{
		GError *err = NULL;
		pipeline = gst_parse_launch(launch, &err);
		if (!pipeline) {
			fprintf(stderr, "pipeline error: %s\n",
				err ? err->message : "unknown");
			if (err)
				g_error_free(err);
			ret = 1;
			goto out;
		}
	}
	appsrc = gst_bin_get_by_name(GST_BIN(pipeline), "src");
	if (!appsrc) {
		fprintf(stderr, "appsrc not found\n");
		ret = 1;
		goto out;
	}

	if (gst_element_set_state(pipeline, GST_STATE_PLAYING) ==
	    GST_STATE_CHANGE_FAILURE) {
		fprintf(stderr, "failed to start pipeline\n");
		ret = 1;
		goto out;
	}
	printf("streaming h265 to %s:%d (rtp mtu 1400)\n", host, port);

	if (ioctl(fd, OV5640_DMA_START) < 0) {
		perror("START");
		ret = 1;
		goto out_pipe;
	}

	/* mmap 全部缓存, 偏移 = 缓存编号 * 4096 */
	for (i = 0; i < (int)bufs; i++) {
		map[i] = mmap(NULL, frame_size, PROT_READ, MAP_SHARED,
			      fd, (off_t)i * 4096);
		if (map[i] == MAP_FAILED) {
			perror("mmap");
			ret = 1;
			goto out_stop;
		}
	}

	frame.sequence = 0;
	for (n = 0; !g_quit && (frames == 0 || n < frames); n++) {
		GstBuffer *buffer;
		GstFlowReturn flow;

		if (ioctl(fd, OV5640_DMA_DQBUF, &frame) < 0) {
			if (errno == EINTR)
				continue;
			perror("DQBUF");
			ret = 1;
			break;
		}
		buffer = gst_buffer_new_wrapped_full(GST_MEMORY_FLAG_READONLY,
						     map[frame.index], frame_size,
						     0, frame_size, NULL, NULL);
		/* 手动打严格递增的时间戳, 编码器输出节奏才稳定 */
		GST_BUFFER_PTS(buffer) =
			gst_util_uint64_scale_int(n, GST_SECOND, FRAMERATE);
		GST_BUFFER_DTS(buffer) = GST_BUFFER_PTS(buffer);
		GST_BUFFER_DURATION(buffer) = GST_SECOND / FRAMERATE;

		flow = gst_app_src_push_buffer(GST_APP_SRC(appsrc), buffer);
		if (flow != GST_FLOW_OK) {
			fprintf(stderr, "push_buffer: %s\n",
				gst_flow_get_name(flow));
			ret = 1;
			break;
		}
		if (n % 30 == 0)
			printf("pushed %u frames\n", n);
	}
	printf("exiting, captured %u frames\n", n);

	gst_app_src_end_of_stream(GST_APP_SRC(appsrc));
	bus = gst_element_get_bus(pipeline);
	gst_bus_timed_pop_filtered(bus, 2 * GST_SECOND,
				   GST_MESSAGE_EOS | GST_MESSAGE_ERROR);
	gst_object_unref(bus);
	gst_object_unref(appsrc);

out_stop:
	ioctl(fd, OV5640_DMA_STOP);
	for (i = 0; i < (int)bufs; i++)
		if (map[i] && map[i] != MAP_FAILED)
			munmap(map[i], frame_size);
out_pipe:
	gst_element_set_state(pipeline, GST_STATE_NULL);
	gst_object_unref(pipeline);
out:
	close(fd);
	return ret;
}
