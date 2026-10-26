/*
 * ov5640_capture.c - ov5640_dma 驱动测试应用 (GStreamer 版本)
 *
 * 打开 /dev/ov5640_dma, mmap 全部缓存, 启动采集, 收帧后通过
 * GStreamer appsrc 推送 RGB888 数据, 经 videoconvert 转成
 * YUV420(NV12), 由 omxh265enc 硬件编码为 H.265, 保存到本地文件。
 *
 * pipeline:
 *   appsrc -> videoconvert -> omxh265enc -> h265parse -> filesink
 *
 * 编译: make CROSS_COMPILE=aarch64-none-linux-gnu-
 * 运行: ./ov5640_capture -n 100 -o /media/sd/video.h265
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <getopt.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

#include <gst/gst.h>
#include <gst/app/gstappsrc.h>

#include "ov5640_dma.h"

#define DEV_DEFAULT "/dev/ov5640_dma"

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [-d device] [-w width] [-h height] [-b bufs] [-n frames] [-o out_file]\n"
		"  -d  device      default %s\n"
		"  -w  width       default 1280\n"
		"  -h  height      default 720\n"
		"  -b  buffers     default 3\n"
		"  -n  frames      default 100, 0 = infinite\n"
		"  -o  out_file    default /tmp/ov5640.h265\n",
		prog, DEV_DEFAULT);
}

int main(int argc, char *argv[])
{
	const char *dev = DEV_DEFAULT;
	const char *out_file = "/tmp/ov5640.h265";
	uint32_t width = 1280, height = 720, bufs = 3, frames = 100;
	struct ov5640_dma_format fmt;
	struct ov5640_dma_frame frame;
	void *map[OV_DMA_MAX_BUF] = { 0 };
	int fd, i, opt, ret = 0;
	uint32_t n;
	size_t frame_size;

	GstElement *pipeline, *appsrc, *videoconvert, *encoder, *parse, *filesink;
	GstCaps *caps;
	GstBus *bus;
	GstMessage *msg;

	while ((opt = getopt(argc, argv, "d:w:h:b:n:o:")) != -1) {
		switch (opt) {
		case 'd': dev = optarg; break;
		case 'w': width = atoi(optarg); break;
		case 'h': height = atoi(optarg); break;
		case 'b': bufs = atoi(optarg); break;
		case 'n': frames = atoi(optarg); break;
		case 'o': out_file = optarg; break;
		default:  usage(argv[0]); return 1;
		}
	}
	if (bufs < 1 || bufs > OV_DMA_MAX_BUF) {
		fprintf(stderr, "buffer count must be 1~%d\n", OV_DMA_MAX_BUF);
		return 1;
	}

	gst_init(&argc, &argv);

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

	/* 构建 GStreamer 编码 pipeline:
	 * appsrc(RGB) -> videoconvert(NV12) -> omxh265enc -> h265parse -> filesink */
	pipeline = gst_pipeline_new("ov5640-enc");
	appsrc = gst_element_factory_make("appsrc", "src");
	videoconvert = gst_element_factory_make("videoconvert", "cvt");
	encoder = gst_element_factory_make("omxh265enc", "enc");
	parse = gst_element_factory_make("h265parse", "parse");
	filesink = gst_element_factory_make("filesink", "sink");
	if (!pipeline || !appsrc || !videoconvert || !encoder || !parse || !filesink) {
		fprintf(stderr, "failed to create gst elements "
			"(appsrc/videoconvert/omxh265enc/h265parse/filesink)\n");
		ret = 1;
		goto out;
	}

	caps = gst_caps_new_simple("video/x-raw",
				   "format", G_TYPE_STRING, "RGB",
				   "width", G_TYPE_INT, (int)width,
				   "height", G_TYPE_INT, (int)height,
				   "framerate", GST_TYPE_FRACTION, 30, 1,
				   NULL);
	g_object_set(appsrc,
		     "caps", caps,
		     "is-live", TRUE,
		     "format", GST_FORMAT_TIME,
		     "do-timestamp", TRUE,
		     NULL);
	gst_caps_unref(caps);

	/* omxh265enc 输入为 NV12 (YUV420) */
	g_object_set(encoder, "target-bitrate", 8000, NULL);
	g_object_set(filesink, "location", out_file, NULL);

	gst_bin_add_many(GST_BIN(pipeline), appsrc, videoconvert, encoder,
			 parse, filesink, NULL);
	if (!gst_element_link_many(appsrc, videoconvert, encoder, parse,
				   filesink, NULL)) {
		fprintf(stderr, "failed to link gst elements\n");
		ret = 1;
		goto out;
	}

	if (gst_element_set_state(pipeline, GST_STATE_PLAYING) ==
	    GST_STATE_CHANGE_FAILURE) {
		fprintf(stderr, "failed to start pipeline\n");
		ret = 1;
		goto out;
	}
	printf("encoding %u frames to %s ...\n", frames, out_file);

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
	for (n = 0; frames == 0 || n < frames; n++) {
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
		flow = gst_app_src_push_buffer(GST_APP_SRC(appsrc), buffer);
		if (flow != GST_FLOW_OK) {
			fprintf(stderr, "push_buffer failed: %s\n",
				gst_flow_get_name(flow));
			ret = 1;
			break;
		}
		printf("frame %u: buf %u, seq %u\n",
		       n, frame.index, frame.sequence);
	}

	gst_app_src_end_of_stream(GST_APP_SRC(appsrc));

	/* 等待编码器 flush 完成 (收到 EOS 或 ERROR) */
	bus = gst_element_get_bus(pipeline);
	msg = gst_bus_timed_pop_filtered(bus, GST_CLOCK_TIME_NONE,
					 GST_MESSAGE_EOS | GST_MESSAGE_ERROR);
	if (msg && GST_MESSAGE_TYPE(msg) == GST_MESSAGE_ERROR) {
		GError *err = NULL;
		gchar *dbg = NULL;
		gst_message_parse_error(msg, &err, &dbg);
		fprintf(stderr, "gst error: %s (%s)\n",
			err->message, dbg ? dbg : "");
		g_error_free(err);
		g_free(dbg);
		ret = 1;
	}
	if (msg)
		gst_message_unref(msg);
	gst_object_unref(bus);
	printf("saved: %s\n", out_file);

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
