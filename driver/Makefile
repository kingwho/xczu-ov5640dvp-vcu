# ov5640_dma 外部内核模块构建 (PetaLinux 2020.2 / kernel 5.4)
#
# 用法:
#   make KDIR=<petalinux 工程内核构建目录> CROSS_COMPILE=<交叉工具链前缀>
#
# 示例:
#   make KDIR=<plnx-proj>/build/tmp/work/.../linux-xlnx/5.4.xx-xilinx-v2020.2/... \
#        CROSS_COMPILE=aarch64-none-linux-gnu- ARCH=arm64
#
# 推荐方式: 直接把本目录内容放到内核源码树 drivers/media/platform/ov5640-dma/
# 并在对应 Kconfig/Makefile 中挂接, 用 petalinux-config -> kernel 一体编译。

obj-m := ov5640_dma.o

KDIR ?= /lib/modules/$(shell uname -r)/build

all:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean

.PHONY: all clean
