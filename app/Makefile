# ov5640_capture 测试应用交叉编译
CROSS_COMPILE ?= aarch64-none-linux-gnu-
CC      := $(CROSS_COMPILE)gcc
CFLAGS  := -Wall -O2 -I../driver

TARGET  := ov5640_capture

all: $(TARGET)

$(TARGET): ov5640_capture.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(TARGET)

.PHONY: all clean
