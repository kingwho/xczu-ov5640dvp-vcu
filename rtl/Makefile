# RTL 仿真 (需要 iverilog)
#
# make            默认 64bit AXI, 64x32
# make CONFIG=32  32bit AXI
# make CONFIG=128 128bit AXI + 65x31 (验证非整拍帧尾)
# make STALL=1    叠加随机 AXI 背压

CONFIG ?= 64

ifeq ($(CONFIG),32)
P = -Ptb_ov5640_dma_top.DW=32
else ifeq ($(CONFIG),128)
P = -Ptb_ov5640_dma_top.DW=128 -Ptb_ov5640_dma_top.TW=65 -Ptb_ov5640_dma_top.TH=31
else
P =
endif

ifneq ($(STALL),)
P += -Ptb_ov5640_dma_top.STALL=1
endif

all:
	iverilog -g2005 $(P) -o /tmp/ov5640_sim \
		ov5640_capture_data.v ov5640_async_fifo.v ov5640_dma_top.v tb_ov5640_dma_top.v
	vvp /tmp/ov5640_sim

.PHONY: all
