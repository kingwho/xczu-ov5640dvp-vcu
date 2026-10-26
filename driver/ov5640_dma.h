/* SPDX-License-Identifier: GPL-2.0 */
/*
 * ov5640_dma.h - OV5640 DVP RGB888 DDR 写入 IP 的寄存器映射与用户态接口
 *
 * 本文件同时被驱动 (kernel) 与测试应用 (userspace) 使用,
 * 也是 RTL 侧 axi-lite 从机需要实现的寄存器规约。
 *
 * 寄存器基地址为 IP 的 AXI-Lite 基地址(例如 0x43C0_0000), 均为 32bit:
 *
 *  offset  name        description
 *  ------  ----------  ------------------------------------------------
 *  0x00    CTRL        bit0   : 采集使能(1=启动, 0=停止)
 *                      bit1   : 帧完成中断使能
 *                      bit2   : 软复位(自清零, 清空内部 FIFO/写通道)
 *  0x04    STATUS      bit0   : 忙(正在向 DDR 写帧数据)
 *                      [3:1]  : 当前正在写入的缓存编号 (0~2)
 *                      [6:4]  : 最近一次写完的缓存编号 (0~2)
 *  0x08    IRQ_STATUS  bit0   : 帧完成中断标志, 写 1 清零 (W1C)
 *  0x0C    WIDTH       图像宽度 (像素)
 *  0x10    HEIGHT      图像高度 (像素)
 *  0x14    FRAME_SIZE  一帧字节数 = WIDTH * HEIGHT * 3 (RGB888)
 *  0x18    BUF_NUM     缓存块数量, 1~3
 *  0x1C    BUF0_LO     缓存 0 DDR 地址低 32bit
 *  0x20    BUF0_HI     缓存 0 DDR 地址高 32bit (32bit 系统填 0)
 *  0x24    BUF1_LO     缓存 1 DDR 地址低 32bit
 *  0x28    BUF1_HI     缓存 1 DDR 地址高 32bit
 *  0x2C    BUF2_LO     缓存 2 DDR 地址低 32bit
 *  0x30    BUF2_HI     缓存 2 DDR 地址高 32bit
 */
#ifndef _OV5640_DMA_H_
#define _OV5640_DMA_H_

#ifdef __KERNEL__
#include <linux/ioctl.h>
#include <linux/types.h>
#else
#include <sys/ioctl.h>
#include <stdint.h>
typedef uint32_t __u32;
#endif

/* ---------------- AXI-Lite 寄存器偏移 ---------------- */
#define OV_DMA_REG_CTRL        0x00
#define OV_DMA_REG_STATUS      0x04
#define OV_DMA_REG_IRQ_STATUS  0x08
#define OV_DMA_REG_WIDTH       0x0C
#define OV_DMA_REG_HEIGHT      0x10
#define OV_DMA_REG_FRAME_SIZE  0x14
#define OV_DMA_REG_BUF_NUM     0x18
#define OV_DMA_REG_BUF0_LO     0x1C
#define OV_DMA_REG_BUF0_HI     0x20
#define OV_DMA_REG_BUF1_LO     0x24
#define OV_DMA_REG_BUF1_HI     0x28
#define OV_DMA_REG_BUF2_LO     0x2C
#define OV_DMA_REG_BUF2_HI     0x30

#define OV_DMA_CTRL_RUN       (1u << 0)
#define OV_DMA_CTRL_IRQ_EN    (1u << 1)
#define OV_DMA_CTRL_SRST      (1u << 2)

#define OV_DMA_STATUS_BUSY    (1u << 0)
#define OV_DMA_STATUS_WIDX_S  1
#define OV_DMA_STATUS_DIDX_S  4

#define OV_DMA_IRQ_FRAME_DONE (1u << 0)

#define OV_DMA_MAX_BUF        3

/* ---------------- 用户态 ioctl ---------------- */
#define OV5640_DMA_MAGIC 'v'

struct ov5640_dma_format {
	__u32 width;
	__u32 height;
};

struct ov5640_dma_frame {
	__u32 index;    /* 写完成的缓存编号 0~2 */
	__u32 sequence; /* 递增帧序号 */
};

#define OV5640_DMA_G_FMT     _IOR(OV5640_DMA_MAGIC, 0, struct ov5640_dma_format)
#define OV5640_DMA_S_FMT     _IOW(OV5640_DMA_MAGIC, 1, struct ov5640_dma_format)
#define OV5640_DMA_S_BUFNUM  _IOW(OV5640_DMA_MAGIC, 2, __u32)
#define OV5640_DMA_G_BUFNUM  _IOR(OV5640_DMA_MAGIC, 3, __u32)
#define OV5640_DMA_DQBUF     _IOWR(OV5640_DMA_MAGIC, 4, struct ov5640_dma_frame)
#define OV5640_DMA_START     _IO(OV5640_DMA_MAGIC, 5)
#define OV5640_DMA_STOP      _IO(OV5640_DMA_MAGIC, 6)

#endif /* _OV5640_DMA_H_ */
