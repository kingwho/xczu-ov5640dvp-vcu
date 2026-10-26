/*
 * ov5640_capture.c - ov5640_dma 驱动测试应用
 *
 * 打开 /dev/ov5640_dma, mmap 全部缓存, 启动采集, 收帧并保存为
 * PPM (P6, RGB888) 图像文件 (可直接用图片查看器打开)。
 *
 * 编译: make CROSS_COMPILE=aarch64-none-linux-gnu-
 * 运行: ./ov5640_capture -n 10 -o /media/sd/frame
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

#include "ov5640_dma.h"

#define DEV_DEFAULT "/dev/ov5640_dma"

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [-d device] [-w width] [-h height] [-b bufs] [-n frames] [-o out_prefix]\n"
		"  -d  device      default %s\n"
		"  -w  width       default 1280\n"
		"  -h  height      default 720\n"
		"  -b  buffers     default 3\n"
		"  -n  frames      default 10, 0 = infinite\n"
		"  -o  out_prefix  default /tmp/ov5640\n",
		prog, DEV_DEFAULT);
}

int main(int argc, char *argv[])
{
	const char *dev = DEV_DEFAULT;
	const char *prefix = "/tmp/ov5640";
	uint32_t width = 1280, height = 720, bufs = 3, frames = 10;
	struct ov5640_dma_format fmt;
	struct ov5640_dma_frame frame;
	void *map[OV_DMA_MAX_BUF] = { 0 };
	int fd, i, opt, ret = 0;
	uint32_t n;
	char path[256];
	FILE *fp;

	while ((opt = getopt(argc, argv, "d:w:h:b:n:o:")) != -1) {
		switch (opt) {
		case 'd': dev = optarg; break;
		case 'w': width = atoi(optarg); break;
		case 'h': height = atoi(optarg); break;
		case 'b': bufs = atoi(optarg); break;
		case 'n': frames = atoi(optarg); break;
		case 'o': prefix = optarg; break;
		default:  usage(argv[0]); return 1;
		}
	}
	if (bufs < 1 || bufs > OV_DMA_MAX_BUF) {
		fprintf(stderr, "buffer count must be 1~3\n");
		return 1;
	}

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
	printf("format: %u x %u, %u buffers, frame %u bytes\n",
	       width, height, bufs, width * height * 3);

	if (ioctl(fd, OV5640_DMA_START) < 0) {
		perror("START");
		ret = 1;
		goto out;
	}

	/* mmap 全部缓存, 偏移 = 缓存编号 * 4096 */
	for (i = 0; i < (int)bufs; i++) {
		map[i] = mmap(NULL, width * height * 3, PROT_READ, MAP_SHARED,
			      fd, (off_t)i * 4096);
		if (map[i] == MAP_FAILED) {
			perror("mmap");
			ret = 1;
			goto out_stop;
		}
	}

	frame.sequence = 0;
	for (n = 0; frames == 0 || n < frames; n++) {
		if (ioctl(fd, OV5640_DMA_DQBUF, &frame) < 0) {
			if (errno == EINTR)
				continue;
			perror("DQBUF");
			ret = 1;
			break;
		}
		snprintf(path, sizeof(path), "%s_%03u_%u.ppm",
			 prefix, n, frame.index);
		fp = fopen(path, "wb");
		if (!fp) {
			perror("fopen");
			ret = 1;
			break;
		}
		/* PPM (P6) 文件头: 魔数 / 宽高 / 最大值 */
		if (fprintf(fp, "P6\n%u %u\n255\n", width, height) < 0) {
			perror("fprintf");
			fclose(fp);
			ret = 1;
			break;
		}
		if (fwrite(map[frame.index], 1, (size_t)width * height * 3, fp)
		    != (size_t)width * height * 3) {
			fprintf(stderr, "short write\n");
			fclose(fp);
			ret = 1;
			break;
		}
		fclose(fp);
		printf("frame %u: buf %u, seq %u -> %s\n",
		       n, frame.index, frame.sequence, path);
	}

out_stop:
	ioctl(fd, OV5640_DMA_STOP);
	for (i = 0; i < (int)bufs; i++)
		if (map[i] && map[i] != MAP_FAILED)
			munmap(map[i], (size_t)width * height * 3);
out:
	close(fd);
	return ret;
}
