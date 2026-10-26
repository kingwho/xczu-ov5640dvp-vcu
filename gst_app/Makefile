# ov5640_capture 测试应用交叉编译 (依赖 GStreamer + omxh265enc)
# bitbake/Yocto 环境下 CC/CFLAGS/LDFLAGS 由环境变量提供;
# 手工交叉编译时用 CROSS_COMPILE 指定前缀
CROSS_COMPILE ?= aarch64-none-linux-gnu-
CC      ?= $(CROSS_COMPILE)gcc
PKG_CONFIG ?= pkg-config

GST_PKGS := gstreamer-1.0 gstreamer-app-1.0
CFLAGS  += -Wall -O2 -I. $(shell $(PKG_CONFIG) --cflags $(GST_PKGS))
LIBS    := $(shell $(PKG_CONFIG) --libs $(GST_PKGS))

TARGET  := ov5640_capture

all: $(TARGET)

$(TARGET): ov5640_capture.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LIBS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
