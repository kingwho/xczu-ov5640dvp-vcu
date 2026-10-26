# ov5640 DMA 工程 (PetaLinux 2020.2 / kernel 5.4)

DVP OV5640 (RGB565 输入) → RGB888 → AXI-Full 写 DDR 的采集 IP 及配套 Linux 驱动。

## 目录结构

```
rtl/    ov5640_capture_data.v   DVP 采集与 RGB565→RGB888 转换 (已有)
        ov5640_dma_top.v        AXI 封装顶层: AXI-Lite 从机 + AXI-Full 写主机 + 写引擎
        ov5640_async_fifo.v     像素跨时钟异步 FIFO (cam_pclk → aclk, 格雷码指针)
        tb_ov5640_dma_top.v     仿真 testbench (iverilog)
        Makefile                仿真脚本
driver/ ov5640_dma.c            Linux 平台驱动 (kernel 5.4, 兼容 5.6+/6.x)
        ov5640_dma.h            AXI-Lite 寄存器映射 + ioctl 接口 (驱动/应用共用)
        ov5640_dma.dtsi         设备树片段示例
        Makefile                外部内核模块构建
app/    ov5640_capture.c        采集测试应用
        Makefile
```

## RTL 顶层 (ov5640_dma_top)

`ov5640_dma_top` 封装 `ov5640_capture_data`，结构与寄存器映射见上文表格，
与驱动 `ov5640_dma.h` 严格一致。要点：

- **AXI4-Lite 从机**：配置分辨率/帧大小/缓存数/3 组缓存 DDR 地址（64bit）、
  启停（RUN）、软复位（SRST）、帧完成中断（电平输出 `irq`，W1C 清除）。
- **AXI4-Full 写主机**（仅写通道）：RGB888 像素按字节流装配成数据拍，
  INCR 突发（默认 16 beat，兼容 AXI3）写入当前缓存，写满 `FRAME_SIZE`
  字节后置位中断并切换下一块缓存（在 `BUF_NUM` 块间轮转）。
- **跨时钟**：24bit 像素异步 FIFO（深度参数化，默认 1024），pclk→aclk。
- **吞吐**：写引擎每 2 个 aclk 消费 1 像素，要求 **aclk ≥ PCLK**（72MHz
  PCLK 时 aclk ≥ 100MHz 建议值即可满足）。
- **参数**：`C_AXI_DATA_WIDTH`(32/64/128)、`C_BURST_BEATS`(≤16)、
  `C_FIFO_ADDR_WIDTH`。帧大小不是数据拍整数倍时最后一拍用 WSTRB 部分写。
- 约束：`FRAME_SIZE` 必须等于 `WIDTH×HEIGHT×3` 且与传感器实际输出一致，
  否则帧数据会错位（IP 按字节计数完成帧，不做行/场对齐纠错）。

### 仿真

```bash
cd rtl
make              # 64bit AXI, 64x32
make CONFIG=32    # 32bit AXI
make CONFIG=128   # 128bit AXI, 65x31 (非整拍帧尾)
make STALL=1      # 叠加随机 AXI 背压
```

testbench 用 AXI-Lite 任务配置 IP，模拟 DVP 摄像头流与 AXI 写从端内存，
校验 4 帧数据的缓存轮转（0→1→2→0）、中断、W1C 与全部像素字节内容。
以上四种配置均已通过。

### Vivado 集成

1. `ov5640_dma_top` 接 AXI SmartConnect/Interconnect：Lite 从机接 PS 主口，
   Full 主机（仅写）接 S_AXI_HP 口；`irq` 接 PL→PS 中断。
2. `aclk` 建议挂 FCLK 或 AXI 时钟（≥100MHz），复位接 `aresetn`。
3. DVP 引脚（pclk/vsync/href/data[7:0]）经 IBUF 进 PL；cam_pclk 建议接
   BUFG。`cam_rst_n`/`cam_pwdn` 由模块固定输出 1/0。

## AXI-Lite 寄存器映射

`rtl/ov5640_dma_top.v` 已按此实现, 定义见 `driver/ov5640_dma.h` 头部注释。摘要:

| offset | 名称 | 说明 |
|--------|------|------|
| 0x00 | CTRL | bit0 采集使能, bit1 中断使能, bit2 软复位 |
| 0x04 | STATUS | bit0 忙, [3:1] 正在写的缓存号, [6:4] 最近写完的缓存号 |
| 0x08 | IRQ_STATUS | bit0 帧完成, W1C |
| 0x0C | WIDTH | 图像宽(像素) |
| 0x10 | HEIGHT | 图像高(像素) |
| 0x14 | FRAME_SIZE | 一帧字节数 = W*H*3 |
| 0x18 | BUF_NUM | 缓存块数 1~3 |
| 0x1C~0x30 | BUFx_LO/HI | 3 块缓存的 DDR 地址 (低/高 32bit) |

## 缓存分配策略 (4KB 对齐 + 连续)

驱动用一次 `dma_alloc_coherent()` 申请 `buf_num * PAGE_ALIGN(frame_size)` 的
整块连续内存 (走 CMA), 再按 `PAGE_ALIGN(frame_size)` 拆分给各缓存。整块基地址
按页对齐、每段长度为页整数倍, 因此每块缓存严格 4KB 对齐且物理连续。

## 编译

### 内核模块

```bash
cd driver
# 方式一: 外部模块 (KDIR 指向 PetaLinux 内核构建目录)
make KDIR=<plnx-proj>/build/linux/sysroot-components/.../linux-xlnx \
     CROSS_COMPILE=aarch64-none-linux-gnu- ARCH=arm64
# 方式二(推荐): 拷入内核树 drivers/media/platform/ov5640-dma/,
# 加 obj-y += ov5640-dma.o 并 petalinux-build -c kernel
```

atk-mpsoc-vcu/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi



```
&ov5640_dma_top_0 {
	sccb-adapter = <&i2c0>;		/* 标准 PS I2C 控制器 (经 EMIO), 或 &axi_iic */
	sccb-addr = <0x3c>;		/* 7bit 地址, 对应 SCCB ID 0x78 */

	width  = <1280>;		/* 输出分辨率 */
	height = <720>;
	total-hsize = <2570>;		/* 行总像素 (帧率) */
	total-vsize = <980>;		/* 场总行数 (帧率) */
	buffer-num = <3>;		/* DDR 缓存块数 1~3 */
};

&vcu_0{
	reset-gpios = <&gpio 78 GPIO_ACTIVE_HIGH>;
};
```

petalinux-create -t modules --name ov5640-dma --enable

atk-mpsoc-vcu/project-spec/meta-user/recipes-modules



### 应用

petalinux-create -t apps --template c -n ov5640-capture --enable



atk-mpsoc-vcu/project-spec/meta-user/recipes-apps

```bash
cd app
make CROSS_COMPILE=aarch64-none-linux-gnu-
```

## 设备树

参考 `driver/ov5640_dma.dtsi`。要点:

- `reg` 与 Vivado 地址分配一致; ZYNQ-7000 PL 中断 61~68 对应 `interrupts = <0 45..52 4>`。
- `sccb-adapter` 指向 SCCB 所挂的标准 I2C 控制器 (`&i2c1` PS I2C 经 EMIO,
  或 PL 侧 `axi_iic`)。驱动使用内核标准 i2c 读写 (`i2c_transfer`),
  不使用 `i2c-gpio` 位绑方案。
- `width/height/total-hsize/total-vsize` 默认 1280x720 / 2570x980 (24MHz 晶振,
  PCLK=72MHz, 约 30fps), 与 `ov5640_init.c` 参数一致。

## 使用

```bash
insmod ov5640_dma.ko
# 采 10 帧 720p RGB888 保存到 /tmp
./ov5640_capture -n 10 -o /tmp/ov5640
# 查看帧数据 (ffmpeg 转换)
ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1280x720 \
       -i /tmp/ov5640_000_0.rgb -frames:v 1 /tmp/frame.png
```

### ioctl 接口

| ioctl | 说明 |
|-------|------|
| `OV5640_DMA_S_FMT` / `G_FMT` | 设置/获取分辨率 (会触发传感器重新初始化) |
| `OV5640_DMA_S_BUFNUM` / `G_BUFNUM` | 设置/获取缓存块数 (1~3) |
| `OV5640_DMA_START` / `STOP` | 启动/停止采集 |
| `OV5640_DMA_DQBUF` | 阻塞等待一帧, 返回缓存编号与帧序号 |
| `mmap` | `offset = 缓存编号 * 4096`, 映射对应 DDR 缓存 |
