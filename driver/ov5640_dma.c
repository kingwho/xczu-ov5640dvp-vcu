// SPDX-License-Identifier: GPL-2.0
/*
 * ov5640_dma.c - OV5640 DVP RGB888 DDR 采集 IP 的 PetaLinux 2020.2 (kernel 5.4) 驱动
 *
 * 平台设备驱动, 管理自定义 PL IP:
 *   - AXI-Lite: 配置分辨率/帧大小/缓存数量/缓存 DDR 地址, 启停, 帧完成中断
 *   - AXI-Full: IP 主动把 RGB888 帧数据写入 DDR (最多 3 块缓存轮转)
 *   - OV5640 SCCB 寄存器配置通过 PS I2C (可经 EMIO) 完成, 内容移植自 ov5640_init.c
 *
 * 缓存分配策略: 整块 dma_alloc_coherent(n * PAGE_ALIGN(frame_size)) 一次性申请,
 * 再按 PAGE_ALIGN(frame_size) 拆分成 n 块, 保证每块缓存 4KB 对齐且物理连续。
 *
 * Copyright (C) 2026
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/miscdevice.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/interrupt.h>
#include <linux/i2c.h>
#include <linux/dma-mapping.h>
#include <linux/fs.h>
#include <linux/mm.h>
#include <linux/poll.h>
#include <linux/compat.h>
#include <linux/sizes.h>
#include <linux/uaccess.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/wait.h>
#include <linux/spinlock.h>
#include <linux/mutex.h>
#include <linux/slab.h>

#include "ov5640_dma.h"

#define DRV_NAME "ov5640-dma"

/* OV5640 7bit I2C(SCCB) 地址: 0x78>>1 */
#define OV5640_I2C_ADDR_DEF   0x3c

/* SCCB 传输失败重试次数 */
#define OV5640_I2C_RETRIES    3

struct ov5640_dma_ctx {
	struct ov5640_dma *cam;
	u32 last_seq;   /* 该打开实例已消费到的帧序号 */
};

struct ov5640_dma {
	struct device *dev;
	void __iomem *base;
	int irq;

	struct i2c_adapter *adap;
	u8 i2c_addr;

	u32 width, height;        /* 输出分辨率 */
	u32 total_h, total_v;     /* 行/场总尺寸 (帧率用) */
	u32 buf_num;              /* 1~3 */
	u32 frame_size;           /* width*height*3 */
	u32 buf_size;             /* PAGE_ALIGN(frame_size) */

	/* 一整块连续内存, 拆成 buf_num 份, 每份 4KB 对齐 */
	void *vaddr;
	dma_addr_t dma;
	u32 total_size;

	bool running;
	bool sensor_ok;           /* 传感器已按当前参数初始化 */
	u32 seq;                  /* 帧完成序号 */
	u32 latest_idx;           /* 最近写完成的缓存编号 */
	spinlock_t slock;         /* 保护 seq/latest_idx/running */
	struct mutex mlock;       /* ioctl 串行化 */
	wait_queue_head_t wq;

	struct miscdevice misc;
};

/* ------------------------------------------------------------------ */
/*                          SCCB (over I2C)                           */
/* ------------------------------------------------------------------ */

/*
 * 标准 I2C 写: START + addr(W) + reg[15:8] + reg[7:0] + data + STOP。
 * 失败时重试, SCCB 偶发 NACK 在重试后一般可恢复。
 */
static int sccb_write_reg16(struct ov5640_dma *cam, u16 reg, u8 val)
{
	u8 buf[3] = { reg >> 8, reg & 0xff, val };
	struct i2c_msg msg = {
		.addr  = cam->i2c_addr,
		.flags = 0,
		.len   = 3,
		.buf   = buf,
	};
	int ret, i;

	for (i = 0; i < OV5640_I2C_RETRIES; i++) {
		ret = i2c_transfer(cam->adap, &msg, 1);
		if (ret == 1) {
			dev_dbg(cam->dev, "i2c wr 0x%04x = 0x%02x\n", reg, val);
			return 0;
		}
		ret = ret < 0 ? ret : -EIO;
		dev_err(cam->dev,
			"i2c write reg 0x%04x val 0x%02x failed (try %d/%d): %d\n",
			reg, val, i + 1, OV5640_I2C_RETRIES, ret);
		if (i + 1 < OV5640_I2C_RETRIES)
			usleep_range(1000, 2000);
	}
	return ret;
}

/*
 * 标准 I2C 读: 先写 2 字节寄存器地址, 重复起始 + addr(R) 读 1 字节。
 */
static int sccb_read_reg16(struct ov5640_dma *cam, u16 reg, u8 *val)
{
	u8 wbuf[2] = { reg >> 8, reg & 0xff };
	struct i2c_msg msgs[2] = {
		{
			.addr  = cam->i2c_addr,
			.flags = 0,
			.len   = 2,
			.buf   = wbuf,
		}, {
			.addr  = cam->i2c_addr,
			.flags = I2C_M_RD,
			.len   = 1,
			.buf   = val,
		},
	};
	int ret, i;

	for (i = 0; i < OV5640_I2C_RETRIES; i++) {
		ret = i2c_transfer(cam->adap, msgs, 2);
		if (ret == 2) {
			dev_dbg(cam->dev, "i2c rd 0x%04x = 0x%02x\n", reg, *val);
			return 0;
		}
		ret = ret < 0 ? ret : -EIO;
		dev_err(cam->dev,
			"i2c read reg 0x%04x failed (try %d/%d): %d\n",
			reg, i + 1, OV5640_I2C_RETRIES, ret);
		if (i + 1 < OV5640_I2C_RETRIES)
			usleep_range(1000, 2000);
	}
	return ret;
}

/* ------------------------------------------------------------------ */
/*                     OV5640 寄存器配置 (移植自 ov5640_init.c)        */
/* ------------------------------------------------------------------ */

/* 3808~380f (分辨率/总尺寸) 为动态参数, 由 ov5640_sensor_init() 单独写入 */
struct ov5640_regval {
	u16 reg;
	u8  val;
};

static const struct ov5640_regval ov5640_init_part1[] = {
	{0x3008, 0x02}, {0x3103, 0x02}, {0x3017, 0xff}, {0x3018, 0xff},
	{0x3037, 0x13}, {0x3108, 0x01}, {0x3630, 0x36}, {0x3631, 0x0e},
	{0x3632, 0xe2}, {0x3633, 0x12}, {0x3621, 0xe0}, {0x3704, 0xa0},
	{0x3703, 0x5a}, {0x3715, 0x78}, {0x3717, 0x01}, {0x370b, 0x60},
	{0x3705, 0x1a}, {0x3905, 0x02}, {0x3906, 0x10}, {0x3901, 0x0a},
	{0x3731, 0x12}, {0x3600, 0x08}, {0x3601, 0x33}, {0x302d, 0x60},
	{0x3620, 0x52}, {0x371b, 0x20}, {0x471c, 0x50}, {0x3a13, 0x43},
	{0x3a18, 0x00}, {0x3a19, 0xf8}, {0x3635, 0x13}, {0x3636, 0x03},
	{0x3634, 0x40}, {0x3622, 0x01}, {0x3c01, 0x34}, {0x3c04, 0x28},
	{0x3c05, 0x98}, {0x3c06, 0x00}, {0x3c07, 0x08}, {0x3c08, 0x00},
	{0x3c09, 0x1c}, {0x3c0a, 0x9c}, {0x3c0b, 0x40}, {0x3810, 0x00},
	{0x3811, 0x10}, {0x3812, 0x00}, {0x3708, 0x64}, {0x4001, 0x02},
	{0x4005, 0x1a}, {0x3000, 0x00}, {0x3004, 0xff}, {0x4300, 0x61},
	{0x501f, 0x01}, {0x440e, 0x00}, {0x5000, 0xa7}, {0x3a0f, 0x30},
	{0x3a10, 0x28}, {0x3a1b, 0x30}, {0x3a1e, 0x26}, {0x3a11, 0x60},
	{0x3a1f, 0x14},
	/* LENC 镜头校准 0x5800~0x583d */
	{0x5800, 0x23}, {0x5801, 0x14}, {0x5802, 0x0f}, {0x5803, 0x0f},
	{0x5804, 0x12}, {0x5805, 0x26}, {0x5806, 0x0c}, {0x5807, 0x08},
	{0x5808, 0x05}, {0x5809, 0x05}, {0x580a, 0x08}, {0x580b, 0x0d},
	{0x580c, 0x08}, {0x580d, 0x03}, {0x580e, 0x00}, {0x580f, 0x00},
	{0x5810, 0x03}, {0x5811, 0x09}, {0x5812, 0x07}, {0x5813, 0x03},
	{0x5814, 0x00}, {0x5815, 0x01}, {0x5816, 0x03}, {0x5817, 0x08},
	{0x5818, 0x0d}, {0x5819, 0x08}, {0x581a, 0x05}, {0x581b, 0x06},
	{0x581c, 0x08}, {0x581d, 0x0e}, {0x581e, 0x29}, {0x581f, 0x17},
	{0x5820, 0x11}, {0x5821, 0x11}, {0x5822, 0x15}, {0x5823, 0x28},
	{0x5824, 0x46}, {0x5825, 0x26}, {0x5826, 0x08}, {0x5827, 0x26},
	{0x5828, 0x64}, {0x5829, 0x26}, {0x582a, 0x24}, {0x582b, 0x22},
	{0x582c, 0x24}, {0x582d, 0x24}, {0x582e, 0x06}, {0x582f, 0x22},
	{0x5830, 0x40}, {0x5831, 0x42}, {0x5832, 0x24}, {0x5833, 0x26},
	{0x5834, 0x24}, {0x5835, 0x22}, {0x5836, 0x22}, {0x5837, 0x26},
	{0x5838, 0x44}, {0x5839, 0x24}, {0x583a, 0x26}, {0x583b, 0x28},
	{0x583c, 0x42}, {0x583d, 0xce},
	/* AWB 自动白平衡 0x5180~0x519e */
	{0x5180, 0xff}, {0x5181, 0xf2}, {0x5182, 0x00}, {0x5183, 0x14},
	{0x5184, 0x25}, {0x5185, 0x24}, {0x5186, 0x09}, {0x5187, 0x09},
	{0x5188, 0x09}, {0x5189, 0x75}, {0x518a, 0x54}, {0x518b, 0xe0},
	{0x518c, 0xb2}, {0x518d, 0x42}, {0x518e, 0x3d}, {0x518f, 0x56},
	{0x5190, 0x46}, {0x5191, 0xf8}, {0x5192, 0x04}, {0x5193, 0x70},
	{0x5194, 0xf0}, {0x5195, 0xf0}, {0x5196, 0x03}, {0x5197, 0x01},
	{0x5198, 0x04}, {0x5199, 0x12}, {0x519a, 0x04}, {0x519b, 0x00},
	{0x519c, 0x06}, {0x519d, 0x82}, {0x519e, 0x38},
	/* Gamma 0x5480~0x5490 */
	{0x5480, 0x01}, {0x5481, 0x08}, {0x5482, 0x14}, {0x5483, 0x28},
	{0x5484, 0x51}, {0x5485, 0x65}, {0x5486, 0x71}, {0x5487, 0x7d},
	{0x5488, 0x87}, {0x5489, 0x91}, {0x548a, 0x9a}, {0x548b, 0xaa},
	{0x548c, 0xb8}, {0x548d, 0xcd}, {0x548e, 0xdd}, {0x548f, 0xea},
	{0x5490, 0x1d},
	/* CMX 色彩矩阵 0x5381~0x538b */
	{0x5381, 0x1e}, {0x5382, 0x5b}, {0x5383, 0x08}, {0x5384, 0x0a},
	{0x5385, 0x7e}, {0x5386, 0x88}, {0x5387, 0x7c}, {0x5388, 0x6c},
	{0x5389, 0x10}, {0x538a, 0x01}, {0x538b, 0x98},
	/* SDE 特殊数字效果 */
	{0x5580, 0x06}, {0x5583, 0x40}, {0x5584, 0x10}, {0x5589, 0x10},
	{0x558a, 0x00}, {0x558b, 0xf8}, {0x501d, 0x40},
	/* CIP 彩色边缘 0x5300~0x530c */
	{0x5300, 0x08}, {0x5301, 0x30}, {0x5302, 0x10}, {0x5303, 0x00},
	{0x5304, 0x08}, {0x5305, 0x30}, {0x5306, 0x08}, {0x5307, 0x16},
	{0x5309, 0x08}, {0x530a, 0x30}, {0x530b, 0x04}, {0x530c, 0x06},
	{0x5025, 0x00},
	/* 系统时钟: 24MHz 输入, PCLK = 72MHz */
	{0x3035, 0x11}, {0x3036, 0x5a}, {0x3c07, 0x08},
	{0x3820, 0x46}, {0x3821, 0x01},
	{0x3814, 0x31}, {0x3815, 0x31},
	/* ISP 输入窗口 (裁剪) */
	{0x3800, 0x00}, {0x3801, 0x00}, {0x3802, 0x00}, {0x3803, 0x04},
	{0x3804, 0x0a}, {0x3805, 0x3f}, {0x3806, 0x07}, {0x3807, 0x9b},
};

static const struct ov5640_regval ov5640_init_part2[] = {
	{0x3820, 0x46}, {0x3813, 0x06}, {0x3618, 0x00}, {0x3612, 0x29},
	{0x3709, 0x52}, {0x370c, 0x03}, {0x3a02, 0x17}, {0x3a03, 0x10},
	{0x3a14, 0x17}, {0x3a15, 0x10}, {0x4004, 0x02}, {0x4713, 0x03},
	{0x4407, 0x04}, {0x460c, 0x22}, {0x4837, 0x22}, {0x3824, 0x02},
	{0x5001, 0xa3}, {0x3b07, 0x0a}, {0x503d, 0x00},
	{0x3016, 0x02}, {0x301c, 0x02},
	{0x3019, 0x02}, {0x3019, 0x00},
};

static int ov5640_write_table(struct ov5640_dma *cam,
			      const struct ov5640_regval *tbl, int n)
{
	int i, ret;

	dev_info(cam->dev, "writing %d sensor registers\n", n);
	for (i = 0; i < n; i++) {
		ret = sccb_write_reg16(cam, tbl[i].reg, tbl[i].val);
		if (ret) {
			dev_err(cam->dev,
				"table write failed at %d/%d: reg 0x%04x val 0x%02x: %d\n",
				i, n, tbl[i].reg, tbl[i].val, ret);
			return ret;
		}
		usleep_range(10, 20);
	}
	dev_info(cam->dev, "wrote %d sensor registers OK\n", n);
	return 0;
}

static int ov5640_sensor_init(struct ov5640_dma *cam)
{
	u16 id = 0;
	u8 val;
	int ret;

	dev_info(cam->dev, "sensor init: %ux%u (total %ux%u), i2c adapter %d addr 0x%02x\n",
		 cam->width, cam->height, cam->total_h, cam->total_v,
		 cam->adap->nr, cam->i2c_addr);

	/* 上电到 SCCB 可访问需等待 20ms */
	usleep_range(20000, 21000);

	dev_info(cam->dev, "reading ov5640 chip id (0x300a/0x300b)...\n");
	ret = sccb_read_reg16(cam, 0x300b, &val);
	if (ret) {
		dev_err(cam->dev, "read chip id LSB failed: %d\n", ret);
		return ret;
	}
	id = val;
	dev_info(cam->dev, "chip id LSB (0x300b) = 0x%02x\n", val);

	ret = sccb_read_reg16(cam, 0x300a, &val);
	if (ret) {
		dev_err(cam->dev, "read chip id MSB failed: %d\n", ret);
		return ret;
	}
	id |= val << 8;
	dev_info(cam->dev, "chip id MSB (0x300a) = 0x%02x, id = 0x%04x\n",
		 val, id);

	if (id != 0x5640) {
		dev_err(cam->dev, "ov5640 id mismatch: 0x%04x (expect 0x5640)\n",
			id);
		return -ENODEV;
	}
	dev_info(cam->dev, "ov5640 detected\n");

	/* 软件复位, 复位后需延时 1ms */
	dev_info(cam->dev, "software reset (0x3008 = 0x82)\n");
	ret = sccb_write_reg16(cam, 0x3008, 0x82);
	if (ret)
		return ret;
	usleep_range(1000, 1100);

	ret = ov5640_write_table(cam, ov5640_init_part1,
				 ARRAY_SIZE(ov5640_init_part1));
	if (ret)
		return ret;

	/* DVP 输出分辨率与总尺寸 */
	dev_info(cam->dev, "writing DVP output size %ux%u, total %ux%u\n",
		 cam->width, cam->height, cam->total_h, cam->total_v);
	ret  = sccb_write_reg16(cam, 0x3808, cam->width  >> 8);
	ret |= sccb_write_reg16(cam, 0x3809, cam->width  & 0xff);
	ret |= sccb_write_reg16(cam, 0x380a, cam->height >> 8);
	ret |= sccb_write_reg16(cam, 0x380b, cam->height & 0xff);
	ret |= sccb_write_reg16(cam, 0x380c, cam->total_h >> 8);
	ret |= sccb_write_reg16(cam, 0x380d, cam->total_h & 0xff);
	ret |= sccb_write_reg16(cam, 0x380e, cam->total_v >> 8);
	ret |= sccb_write_reg16(cam, 0x380f, cam->total_v & 0xff);
	if (ret) {
		dev_err(cam->dev, "write DVP size regs (0x3808~0x380f) failed: %d\n",
			ret);
		return ret;
	}

	ret = ov5640_write_table(cam, ov5640_init_part2,
				 ARRAY_SIZE(ov5640_init_part2));
	if (ret)
		return ret;

	dev_info(cam->dev, "sensor init done\n");
	return 0;
}

/* ------------------------------------------------------------------ */
/*                          DDR 缓存分配                               */
/* ------------------------------------------------------------------ */

static void ov5640_dma_free_buffers(struct ov5640_dma *cam)
{
	if (cam->vaddr) {
		dev_info(cam->dev, "freeing %u bytes coherent buffer (dma %pad)\n",
			 cam->total_size, &cam->dma);
		dma_free_coherent(cam->dev, cam->total_size,
				  cam->vaddr, cam->dma);
		cam->vaddr = NULL;
		cam->dma = 0;
		cam->total_size = 0;
	} else {
		dev_dbg(cam->dev, "no buffer to free\n");
	}
}

/*
 * 整块申请 n * buf_size 的连续内存再拆分:
 * 基地址本身 >= PAGE_SIZE 对齐, buf_size 为 PAGE_SIZE 整数倍,
 * 因此每块缓存天然 4KB 对齐且物理连续。
 */
static int ov5640_dma_alloc_buffers(struct ov5640_dma *cam)
{
	cam->frame_size = cam->width * cam->height * 3;
	cam->buf_size = PAGE_ALIGN(cam->frame_size);
	cam->total_size = cam->buf_size * cam->buf_num;

	cam->vaddr = dma_alloc_coherent(cam->dev, cam->total_size,
					&cam->dma, GFP_KERNEL);
	if (!cam->vaddr) {
		dev_err(cam->dev, "failed to alloc %u bytes coherent buffer\n",
			cam->total_size);
		cam->total_size = 0;
		return -ENOMEM;
	}

	dev_info(cam->dev,
		 "%u x %u, frame %u bytes, %u buffers, base dma %pad (4k aligned, contiguous)\n",
		 cam->width, cam->height, cam->frame_size, cam->buf_num,
		 &cam->dma);
	return 0;
}

/* ------------------------------------------------------------------ */
/*                        AXI-Lite 寄存器访问                          */
/* ------------------------------------------------------------------ */

static inline void ov_wr(struct ov5640_dma *cam, u32 off, u32 val)
{
	iowrite32(val, cam->base + off);
}

static inline u32 ov_rd(struct ov5640_dma *cam, u32 off)
{
	return ioread32(cam->base + off);
}

static void ov5640_dma_hw_config(struct ov5640_dma *cam)
{
	int i;

	dev_info(cam->dev,
		 "hw config: %ux%u, frame_size %u, buf_num %u, buf_size %u\n",
		 cam->width, cam->height, cam->frame_size, cam->buf_num,
		 cam->buf_size);

	/* 停止并软复位写通道 */
	ov_wr(cam, OV_DMA_REG_CTRL, 0);
	ov_wr(cam, OV_DMA_REG_CTRL, OV_DMA_CTRL_SRST);
	udelay(10);
	ov_wr(cam, OV_DMA_REG_CTRL, 0);
	dev_dbg(cam->dev, "write channel soft reset done\n");

	ov_wr(cam, OV_DMA_REG_WIDTH, cam->width);
	ov_wr(cam, OV_DMA_REG_HEIGHT, cam->height);
	ov_wr(cam, OV_DMA_REG_FRAME_SIZE, cam->frame_size);
	ov_wr(cam, OV_DMA_REG_BUF_NUM, cam->buf_num);

	for (i = 0; i < OV_DMA_MAX_BUF; i++) {
		u32 lo = 0, hi = 0;
		if (i < cam->buf_num) {
			dma_addr_t addr = cam->dma + (dma_addr_t)i * cam->buf_size;
			lo = lower_32_bits(addr);
			hi = upper_32_bits(addr);
			dev_dbg(cam->dev, "buf[%d] dma addr 0x%08x%08x\n",
				i, hi, lo);
		} else {
			dev_dbg(cam->dev, "buf[%d] disabled\n", i);
		}
		ov_wr(cam, OV_DMA_REG_BUF0_LO + i * 8, lo);
		ov_wr(cam, OV_DMA_REG_BUF0_HI + i * 8, hi);
	}

	/* 清残留中断标志 */
	ov_wr(cam, OV_DMA_REG_IRQ_STATUS, OV_DMA_IRQ_FRAME_DONE);
}

/* ------------------------------------------------------------------ */
/*                            中断处理                                 */
/* ------------------------------------------------------------------ */

static irqreturn_t ov5640_dma_irq(int irq, void *data)
{
	struct ov5640_dma *cam = data;
	u32 sts, status, done_idx, seq;
	irqreturn_t ret = IRQ_NONE;

	sts = ov_rd(cam, OV_DMA_REG_IRQ_STATUS);
	if (sts & OV_DMA_IRQ_FRAME_DONE) {
		ov_wr(cam, OV_DMA_REG_IRQ_STATUS, OV_DMA_IRQ_FRAME_DONE);
		status = ov_rd(cam, OV_DMA_REG_STATUS);
		done_idx = (status >> OV_DMA_STATUS_DIDX_S) & 0x7;
		spin_lock(&cam->slock);
		cam->latest_idx = done_idx;
		cam->seq++;
		seq = cam->seq;
		spin_unlock(&cam->slock);
		dev_dbg_ratelimited(cam->dev,
				    "frame done irq: seq %u, done buf %u, status 0x%08x\n",
				    seq, done_idx, status);
		wake_up_interruptible(&cam->wq);
		ret = IRQ_HANDLED;
	} else if (sts) {
		dev_warn_ratelimited(cam->dev,
				     "unhandled irq status 0x%08x\n", sts);
	}

	return ret;
}

/* ------------------------------------------------------------------ */
/*                         采集启停                                    */
/* ------------------------------------------------------------------ */

static int ov5640_dma_start(struct ov5640_dma *cam)
{
	unsigned long flags;
	int ret;

	dev_info(cam->dev, "capture start requested\n");

	if (!cam->vaddr) {
		dev_info(cam->dev, "no ddr buffer yet, allocating\n");
		ret = ov5640_dma_alloc_buffers(cam);
		if (ret)
			return ret;
	}

	if (!cam->sensor_ok) {
		dev_info(cam->dev, "sensor not initialized yet, initializing\n");
		ret = ov5640_sensor_init(cam);
		if (ret) {
			dev_err(cam->dev, "ov5640 sensor init failed: %d\n", ret);
			return ret;
		}
		cam->sensor_ok = true;
		/* PL 侧 wait_done 需等寄存器配置稳定后的若干帧, 稍作延时 */
		msleep(200);
	} else {
		dev_dbg(cam->dev, "sensor already initialized, skip\n");
	}

	spin_lock_irqsave(&cam->slock, flags);
	cam->seq = 0;
	cam->running = true;
	spin_unlock_irqrestore(&cam->slock, flags);

	ov5640_dma_hw_config(cam);
	ov_wr(cam, OV_DMA_REG_CTRL, OV_DMA_CTRL_RUN | OV_DMA_CTRL_IRQ_EN);
	dev_dbg(cam->dev, "ctrl reg -> 0x%08x (RUN|IRQ_EN)\n",
		OV_DMA_CTRL_RUN | OV_DMA_CTRL_IRQ_EN);

	dev_info(cam->dev, "capture started\n");
	return 0;
}

static void ov5640_dma_stop(struct ov5640_dma *cam)
{
	unsigned long flags;

	dev_info(cam->dev, "capture stop requested, seq = %u\n",
		 READ_ONCE(cam->seq));

	ov_wr(cam, OV_DMA_REG_CTRL, 0);

	spin_lock_irqsave(&cam->slock, flags);
	cam->running = false;
	spin_unlock_irqrestore(&cam->slock, flags);
	wake_up_interruptible(&cam->wq);

	dev_info(cam->dev, "capture stopped\n");
}

/* ------------------------------------------------------------------ */
/*                          字符设备接口                               */
/* ------------------------------------------------------------------ */

static int ov5640_dma_open(struct inode *inode, struct file *filp)
{
	struct miscdevice *misc = filp->private_data;
	struct ov5640_dma *cam = container_of(misc, struct ov5640_dma, misc);
	struct ov5640_dma_ctx *ctx;

	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
	if (!ctx)
		return -ENOMEM;
	ctx->cam = cam;
	ctx->last_seq = 0;
	filp->private_data = ctx;
	dev_dbg(cam->dev, "device opened\n");
	return 0;
}

static int ov5640_dma_release(struct inode *inode, struct file *filp)
{
	struct ov5640_dma_ctx *ctx = filp->private_data;
	struct ov5640_dma *cam = ctx->cam;

	mutex_lock(&cam->mlock);
	if (cam->running) {
		dev_dbg(cam->dev, "still running on release, stopping\n");
		ov5640_dma_stop(cam);
	}
	mutex_unlock(&cam->mlock);

	kfree(ctx);
	filp->private_data = NULL;
	dev_dbg(cam->dev, "device closed\n");
	return 0;
}

static int ov5640_dma_mmap(struct file *filp, struct vm_area_struct *vma)
{
	struct ov5640_dma_ctx *ctx = filp->private_data;
	struct ov5640_dma *cam = ctx->cam;
	unsigned long size = vma->vm_end - vma->vm_start;
	u32 index = vma->vm_pgoff;   /* 偏移 = 缓存编号 * PAGE_SIZE */
	int ret;

	if (!cam->vaddr) {
		dev_err(cam->dev, "mmap before buffer alloc (start not called)\n");
		return -ENOMEM;
	}
	if (size > cam->buf_size) {
		dev_err(cam->dev, "mmap size %lu > buf size %u\n",
			size, cam->buf_size);
		return -EINVAL;
	}
	if (index >= cam->buf_num) {
		dev_err(cam->dev, "mmap index %u >= buf_num %u\n",
			index, cam->buf_num);
		return -EINVAL;
	}

	vma->vm_pgoff = 0;
	ret = dma_mmap_coherent(cam->dev, vma,
				cam->vaddr + (unsigned long)index * cam->buf_size,
				cam->dma + (dma_addr_t)index * cam->buf_size,
				cam->buf_size);
	if (ret)
		dev_err(cam->dev, "mmap buf %u (size %lu) failed: %d\n",
			index, size, ret);
	else
		dev_dbg(cam->dev, "mmap buf %u (size %lu) ok\n", index, size);
	return ret;
}

static __poll_t ov5640_dma_poll(struct file *filp, poll_table *wait)
{
	struct ov5640_dma_ctx *ctx = filp->private_data;
	struct ov5640_dma *cam = ctx->cam;
	__poll_t mask = 0;

	poll_wait(filp, &cam->wq, wait);

	spin_lock_irq(&cam->slock);
	if (!cam->running)
		mask |= EPOLLERR;
	else if (cam->seq != ctx->last_seq)
		mask |= EPOLLIN | EPOLLRDNORM;
	spin_unlock_irq(&cam->slock);

	return mask;
}

static long ov5640_dma_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
	struct ov5640_dma_ctx *ctx = filp->private_data;
	struct ov5640_dma *cam = ctx->cam;
	void __user *uarg = (void __user *)arg;
	struct ov5640_dma_format fmt;
	struct ov5640_dma_frame frame;
	u32 bufnum;
	int ret = 0;

	mutex_lock(&cam->mlock);

	switch (cmd) {
	case OV5640_DMA_G_FMT:
		dev_dbg(cam->dev, "ioctl G_FMT: %ux%u\n",
			cam->width, cam->height);
		fmt.width = cam->width;
		fmt.height = cam->height;
		ret = copy_to_user(uarg, &fmt, sizeof(fmt)) ? -EFAULT : 0;
		break;

	case OV5640_DMA_S_FMT:
		if (cam->running) {
			dev_dbg(cam->dev, "ioctl S_FMT rejected: running\n");
			ret = -EBUSY;
			break;
		}
		if (copy_from_user(&fmt, uarg, sizeof(fmt))) {
			ret = -EFAULT;
			break;
		}
		dev_dbg(cam->dev, "ioctl S_FMT: %ux%u -> %ux%u\n",
			cam->width, cam->height, fmt.width, fmt.height);
		if (fmt.width == 0 || fmt.height == 0 ||
		    fmt.width * fmt.height * 3 > SZ_32M) {
			dev_err(cam->dev, "invalid format %ux%u\n",
				fmt.width, fmt.height);
			ret = -EINVAL;
			break;
		}
		cam->width = fmt.width;
		cam->height = fmt.height;
		/* 分辨率变化后需重新初始化传感器, 释放旧缓存 */
		cam->sensor_ok = false;
		ov5640_dma_free_buffers(cam);
		break;

	case OV5640_DMA_G_BUFNUM:
		dev_dbg(cam->dev, "ioctl G_BUFNUM: %u\n", cam->buf_num);
		bufnum = cam->buf_num;
		ret = copy_to_user(uarg, &bufnum, sizeof(bufnum)) ? -EFAULT : 0;
		break;

	case OV5640_DMA_S_BUFNUM:
		if (cam->running) {
			dev_dbg(cam->dev, "ioctl S_BUFNUM rejected: running\n");
			ret = -EBUSY;
			break;
		}
		if (copy_from_user(&bufnum, uarg, sizeof(bufnum))) {
			ret = -EFAULT;
			break;
		}
		dev_dbg(cam->dev, "ioctl S_BUFNUM: %u -> %u\n",
			cam->buf_num, bufnum);
		if (bufnum < 1 || bufnum > OV_DMA_MAX_BUF) {
			dev_err(cam->dev, "invalid buf num %u (1~%d)\n",
				bufnum, OV_DMA_MAX_BUF);
			ret = -EINVAL;
			break;
		}
		cam->buf_num = bufnum;
		ov5640_dma_free_buffers(cam);
		break;

	case OV5640_DMA_START:
		dev_dbg(cam->dev, "ioctl START\n");
		ret = ov5640_dma_start(cam);
		break;

	case OV5640_DMA_STOP:
		dev_dbg(cam->dev, "ioctl STOP\n");
		if (cam->running)
			ov5640_dma_stop(cam);
		break;

	case OV5640_DMA_DQBUF:
		ret = wait_event_interruptible(cam->wq,
			!cam->running ||
			READ_ONCE(cam->seq) != ctx->last_seq);
		if (ret) {
			dev_dbg(cam->dev, "dqbuf interrupted: %d\n", ret);
			break;
		}
		if (!cam->running) {
			dev_dbg(cam->dev, "dqbuf: capture stopped\n");
			ret = -EIO;
			break;
		}
		spin_lock_irq(&cam->slock);
		frame.index = cam->latest_idx;
		frame.sequence = cam->seq;
		ctx->last_seq = cam->seq;
		spin_unlock_irq(&cam->slock);
		dev_dbg(cam->dev, "dqbuf: frame seq %u, buf %u\n",
			frame.sequence, frame.index);
		ret = copy_to_user(uarg, &frame, sizeof(frame)) ? -EFAULT : 0;
		break;

	default:
		dev_err(cam->dev, "unsupported ioctl 0x%08x\n", cmd);
		ret = -ENOTTY;
		break;
	}

	mutex_unlock(&cam->mlock);
	return ret;
}

static const struct file_operations ov5640_dma_fops = {
	.owner		= THIS_MODULE,
	.open		= ov5640_dma_open,
	.release	= ov5640_dma_release,
	.mmap		= ov5640_dma_mmap,
	.poll		= ov5640_dma_poll,
	.unlocked_ioctl	= ov5640_dma_ioctl,
	/* compat_ptr_ioctl 于 5.6 引入; ioctl 参数为指针, 布局天然兼容 */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 6, 0)
	.compat_ioctl	= compat_ptr_ioctl,
#else
	.compat_ioctl	= ov5640_dma_ioctl,
#endif
};

/* ------------------------------------------------------------------ */
/*                          平台驱动                                   */
/* ------------------------------------------------------------------ */

static int ov5640_dma_probe(struct platform_device *pdev)
{
	struct ov5640_dma *cam;
	struct device_node *np = pdev->dev.of_node;
	struct device_node *adap_np;
	u32 val;
	int ret;

	cam = devm_kzalloc(&pdev->dev, sizeof(*cam), GFP_KERNEL);
	if (!cam)
		return -ENOMEM;

	cam->dev = &pdev->dev;
	spin_lock_init(&cam->slock);
	mutex_init(&cam->mlock);
	init_waitqueue_head(&cam->wq);
	platform_set_drvdata(pdev, cam);

	cam->base = devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(cam->base))
		return PTR_ERR(cam->base);
	dev_dbg(&pdev->dev, "axi-lite base remapped\n");

	cam->irq = platform_get_irq(pdev, 0);
	if (cam->irq < 0) {
		dev_err(&pdev->dev, "missing interrupt resource: %d\n", cam->irq);
		return cam->irq;
	}
	dev_dbg(&pdev->dev, "irq %d\n", cam->irq);

	/* 默认 720P: 与 ov5640_init.c 的 1280x720 (总尺寸 2570x980) 一致 */
	cam->width = 1280;
	cam->height = 720;
	cam->total_h = 2570;
	cam->total_v = 980;
	cam->buf_num = 3;

	of_property_read_u32(np, "width", &cam->width);
	of_property_read_u32(np, "height", &cam->height);
	of_property_read_u32(np, "total-hsize", &cam->total_h);
	of_property_read_u32(np, "total-vsize", &cam->total_v);
	of_property_read_u32(np, "buffer-num", &cam->buf_num);
	if (cam->buf_num < 1 || cam->buf_num > OV_DMA_MAX_BUF)
		cam->buf_num = 3;
	dev_info(&pdev->dev,
		 "dt config: %ux%u (total %ux%u), %u buffers\n",
		 cam->width, cam->height, cam->total_h, cam->total_v,
		 cam->buf_num);

	cam->i2c_addr = OV5640_I2C_ADDR_DEF;
	val = 0;
	of_property_read_u32(np, "sccb-addr", &val);
	if (val)
		cam->i2c_addr = val;
	dev_info(&pdev->dev, "i2c slave addr 0x%02x (sccb id 0x%02x)\n",
		 cam->i2c_addr, cam->i2c_addr << 1);

	/* SCCB 所挂的标准 I2C 控制器 (PS I2C 经 EMIO 或 PL AXI IIC) */
	adap_np = of_parse_phandle(np, "sccb-adapter", 0);
	if (adap_np) {
		cam->adap = of_find_i2c_adapter_by_node(adap_np);
		of_node_put(adap_np);
		if (!cam->adap)
			return -EPROBE_DEFER;
	} else {
		dev_err(&pdev->dev, "missing 'sccb-adapter' phandle\n");
		return -EINVAL;
	}
	dev_info(&pdev->dev, "sccb on i2c adapter %d (%s)\n",
		 cam->adap->nr, cam->adap->name);

	/* 探测阶段非致命地验证 I2C 链路: 读取 OV5640 chip id 仅用于打日志 */
	{
		u8 id_l = 0, id_h = 0;

		usleep_range(20000, 21000);
		if (sccb_read_reg16(cam, 0x300b, &id_l) == 0 &&
		    sccb_read_reg16(cam, 0x300a, &id_h) == 0) {
			u16 id = (id_h << 8) | id_l;

			if (id == 0x5640)
				dev_info(&pdev->dev, "probe: ov5640 id 0x%04x OK\n",
					 id);
			else
				dev_warn(&pdev->dev,
					 "probe: i2c ok but chip id 0x%04x != 0x5640\n",
					 id);
		} else {
			dev_warn(&pdev->dev,
				 "probe: i2c read chip id failed, check camera/sccb-adapter\n");
		}
	}

	ret = devm_request_irq(&pdev->dev, cam->irq, ov5640_dma_irq, 0,
			       dev_name(&pdev->dev), cam);
	if (ret) {
		dev_err(&pdev->dev, "request irq %d failed: %d\n",
			cam->irq, ret);
		ret = -ENOENT;
		goto err_put_adap;
	}

	cam->misc.minor = MISC_DYNAMIC_MINOR;
	cam->misc.name = "ov5640_dma";
	cam->misc.fops = &ov5640_dma_fops;
	ret = misc_register(&cam->misc);
	if (ret) {
		dev_err(&pdev->dev, "misc_register failed: %d\n", ret);
		goto err_put_adap;
	}

	dev_info(&pdev->dev,
		 "ov5640-dma probed: irq %d, i2c adapter %d addr 0x%02x\n",
		 cam->irq, cam->adap->nr, cam->i2c_addr);
	return 0;

err_put_adap:
	i2c_put_adapter(cam->adap);
	return ret;
}

/* kernel >= 6.11 的 .remove 回调为 void 返回 */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 11, 0)
static void ov5640_dma_remove(struct platform_device *pdev)
{
	struct ov5640_dma *cam = platform_get_drvdata(pdev);

	dev_info(&pdev->dev, "removing driver\n");
	ov5640_dma_stop(cam);
	ov5640_dma_free_buffers(cam);
	misc_deregister(&cam->misc);
	i2c_put_adapter(cam->adap);
}
#else
static int ov5640_dma_remove(struct platform_device *pdev)
{
	struct ov5640_dma *cam = platform_get_drvdata(pdev);

	dev_info(&pdev->dev, "removing driver\n");
	ov5640_dma_stop(cam);
	ov5640_dma_free_buffers(cam);
	misc_deregister(&cam->misc);
	i2c_put_adapter(cam->adap);
	return 0;
}
#endif

static const struct of_device_id ov5640_dma_of_match[] = {
	{ .compatible = "alinx,ov5640-dma-1.0" },
	{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, ov5640_dma_of_match);

static struct platform_driver ov5640_dma_driver = {
	.probe	= ov5640_dma_probe,
	.remove	= ov5640_dma_remove,
	.driver	= {
		.name		= DRV_NAME,
		.of_match_table	= ov5640_dma_of_match,
	},
};

module_platform_driver(ov5640_dma_driver);

MODULE_AUTHOR("ov5640-dma driver");
MODULE_DESCRIPTION("OV5640 DVP RGB888 DDR capture DMA driver (PetaLinux 2020.2, kernel 5.4)");
MODULE_LICENSE("GPL v2");
