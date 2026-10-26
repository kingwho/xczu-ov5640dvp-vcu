//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Sat Oct 24 15:08:07 2026
//Host        : DESKTOP-6150TMC running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=14,numReposBlks=10,numNonXlnxBlks=0,numHierBlks=4,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (IIC_0_0_scl_i,
    IIC_0_0_scl_o,
    IIC_0_0_scl_t,
    IIC_0_0_sda_i,
    IIC_0_0_sda_o,
    IIC_0_0_sda_t,
    cam_data_0,
    cam_href_0,
    cam_pclk_0,
    cam_pwdn_0,
    cam_rst_n_0,
    cam_vsync_0);
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_0_0 SCL_I" *) input IIC_0_0_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_0_0 SCL_O" *) output IIC_0_0_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_0_0 SCL_T" *) output IIC_0_0_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_0_0 SDA_I" *) input IIC_0_0_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_0_0 SDA_O" *) output IIC_0_0_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_0_0 SDA_T" *) output IIC_0_0_sda_t;
  input [7:0]cam_data_0;
  input cam_href_0;
  input cam_pclk_0;
  output [0:0]cam_pwdn_0;
  output [0:0]cam_rst_n_0;
  input cam_vsync_0;

  wire [7:0]cam_data_0_1;
  wire cam_href_0_1;
  wire cam_pclk_0_1;
  wire cam_vsync_0_1;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_clk_out2;
  wire ov5640_dma_top_0_cam_pwdn;
  wire ov5640_dma_top_0_cam_rst_n;
  wire ov5640_dma_top_0_irq;
  wire [31:0]ov5640_dma_top_0_m_axi_AWADDR;
  wire [1:0]ov5640_dma_top_0_m_axi_AWBURST;
  wire [7:0]ov5640_dma_top_0_m_axi_AWLEN;
  wire ov5640_dma_top_0_m_axi_AWREADY;
  wire [2:0]ov5640_dma_top_0_m_axi_AWSIZE;
  wire ov5640_dma_top_0_m_axi_AWVALID;
  wire ov5640_dma_top_0_m_axi_BREADY;
  wire [1:0]ov5640_dma_top_0_m_axi_BRESP;
  wire ov5640_dma_top_0_m_axi_BVALID;
  wire [63:0]ov5640_dma_top_0_m_axi_WDATA;
  wire ov5640_dma_top_0_m_axi_WLAST;
  wire ov5640_dma_top_0_m_axi_WREADY;
  wire [7:0]ov5640_dma_top_0_m_axi_WSTRB;
  wire ov5640_dma_top_0_m_axi_WVALID;
  wire [39:0]ps8_0_axi_periph_M00_AXI_ARADDR;
  wire [2:0]ps8_0_axi_periph_M00_AXI_ARPROT;
  wire [0:0]ps8_0_axi_periph_M00_AXI_ARREADY;
  wire [0:0]ps8_0_axi_periph_M00_AXI_ARVALID;
  wire [39:0]ps8_0_axi_periph_M00_AXI_AWADDR;
  wire [2:0]ps8_0_axi_periph_M00_AXI_AWPROT;
  wire [0:0]ps8_0_axi_periph_M00_AXI_AWREADY;
  wire [0:0]ps8_0_axi_periph_M00_AXI_AWVALID;
  wire [0:0]ps8_0_axi_periph_M00_AXI_BREADY;
  wire [1:0]ps8_0_axi_periph_M00_AXI_BRESP;
  wire [0:0]ps8_0_axi_periph_M00_AXI_BVALID;
  wire [31:0]ps8_0_axi_periph_M00_AXI_RDATA;
  wire [0:0]ps8_0_axi_periph_M00_AXI_RREADY;
  wire [1:0]ps8_0_axi_periph_M00_AXI_RRESP;
  wire [0:0]ps8_0_axi_periph_M00_AXI_RVALID;
  wire [31:0]ps8_0_axi_periph_M00_AXI_WDATA;
  wire [0:0]ps8_0_axi_periph_M00_AXI_WREADY;
  wire [3:0]ps8_0_axi_periph_M00_AXI_WSTRB;
  wire [0:0]ps8_0_axi_periph_M00_AXI_WVALID;
  wire [39:0]ps8_0_axi_periph_M01_AXI_ARADDR;
  wire [2:0]ps8_0_axi_periph_M01_AXI_ARPROT;
  wire ps8_0_axi_periph_M01_AXI_ARREADY;
  wire ps8_0_axi_periph_M01_AXI_ARVALID;
  wire [39:0]ps8_0_axi_periph_M01_AXI_AWADDR;
  wire [2:0]ps8_0_axi_periph_M01_AXI_AWPROT;
  wire ps8_0_axi_periph_M01_AXI_AWREADY;
  wire ps8_0_axi_periph_M01_AXI_AWVALID;
  wire ps8_0_axi_periph_M01_AXI_BREADY;
  wire [1:0]ps8_0_axi_periph_M01_AXI_BRESP;
  wire ps8_0_axi_periph_M01_AXI_BVALID;
  wire [31:0]ps8_0_axi_periph_M01_AXI_RDATA;
  wire ps8_0_axi_periph_M01_AXI_RREADY;
  wire [1:0]ps8_0_axi_periph_M01_AXI_RRESP;
  wire ps8_0_axi_periph_M01_AXI_RVALID;
  wire [31:0]ps8_0_axi_periph_M01_AXI_WDATA;
  wire ps8_0_axi_periph_M01_AXI_WREADY;
  wire [3:0]ps8_0_axi_periph_M01_AXI_WSTRB;
  wire ps8_0_axi_periph_M01_AXI_WVALID;
  wire [0:0]rst_ps8_0_99M_peripheral_aresetn;
  wire [48:0]smartconnect_0_M00_AXI_ARADDR;
  wire [1:0]smartconnect_0_M00_AXI_ARBURST;
  wire [3:0]smartconnect_0_M00_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M00_AXI_ARLEN;
  wire [0:0]smartconnect_0_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire [3:0]smartconnect_0_M00_AXI_ARQOS;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire [2:0]smartconnect_0_M00_AXI_ARSIZE;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [48:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M00_AXI_AWLEN;
  wire [0:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire [3:0]smartconnect_0_M00_AXI_AWQOS;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [127:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RLAST;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [127:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [15:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [43:0]vcu_0_M_AXI_DEC0_ARADDR;
  wire [1:0]vcu_0_M_AXI_DEC0_ARBURST;
  wire [3:0]vcu_0_M_AXI_DEC0_ARCACHE;
  wire [3:0]vcu_0_M_AXI_DEC0_ARID;
  wire [7:0]vcu_0_M_AXI_DEC0_ARLEN;
  wire vcu_0_M_AXI_DEC0_ARLOCK;
  wire [2:0]vcu_0_M_AXI_DEC0_ARPROT;
  wire [3:0]vcu_0_M_AXI_DEC0_ARQOS;
  wire vcu_0_M_AXI_DEC0_ARREADY;
  wire [2:0]vcu_0_M_AXI_DEC0_ARSIZE;
  wire vcu_0_M_AXI_DEC0_ARVALID;
  wire [43:0]vcu_0_M_AXI_DEC0_AWADDR;
  wire [1:0]vcu_0_M_AXI_DEC0_AWBURST;
  wire [3:0]vcu_0_M_AXI_DEC0_AWCACHE;
  wire [3:0]vcu_0_M_AXI_DEC0_AWID;
  wire [7:0]vcu_0_M_AXI_DEC0_AWLEN;
  wire vcu_0_M_AXI_DEC0_AWLOCK;
  wire [2:0]vcu_0_M_AXI_DEC0_AWPROT;
  wire [3:0]vcu_0_M_AXI_DEC0_AWQOS;
  wire vcu_0_M_AXI_DEC0_AWREADY;
  wire [2:0]vcu_0_M_AXI_DEC0_AWSIZE;
  wire vcu_0_M_AXI_DEC0_AWVALID;
  wire [5:0]vcu_0_M_AXI_DEC0_BID;
  wire vcu_0_M_AXI_DEC0_BREADY;
  wire [1:0]vcu_0_M_AXI_DEC0_BRESP;
  wire vcu_0_M_AXI_DEC0_BVALID;
  wire [127:0]vcu_0_M_AXI_DEC0_RDATA;
  wire [5:0]vcu_0_M_AXI_DEC0_RID;
  wire vcu_0_M_AXI_DEC0_RLAST;
  wire vcu_0_M_AXI_DEC0_RREADY;
  wire [1:0]vcu_0_M_AXI_DEC0_RRESP;
  wire vcu_0_M_AXI_DEC0_RVALID;
  wire [127:0]vcu_0_M_AXI_DEC0_WDATA;
  wire vcu_0_M_AXI_DEC0_WLAST;
  wire vcu_0_M_AXI_DEC0_WREADY;
  wire [15:0]vcu_0_M_AXI_DEC0_WSTRB;
  wire vcu_0_M_AXI_DEC0_WVALID;
  wire [43:0]vcu_0_M_AXI_DEC1_ARADDR;
  wire [1:0]vcu_0_M_AXI_DEC1_ARBURST;
  wire [3:0]vcu_0_M_AXI_DEC1_ARCACHE;
  wire [3:0]vcu_0_M_AXI_DEC1_ARID;
  wire [7:0]vcu_0_M_AXI_DEC1_ARLEN;
  wire vcu_0_M_AXI_DEC1_ARLOCK;
  wire [2:0]vcu_0_M_AXI_DEC1_ARPROT;
  wire [3:0]vcu_0_M_AXI_DEC1_ARQOS;
  wire vcu_0_M_AXI_DEC1_ARREADY;
  wire [2:0]vcu_0_M_AXI_DEC1_ARSIZE;
  wire vcu_0_M_AXI_DEC1_ARVALID;
  wire [43:0]vcu_0_M_AXI_DEC1_AWADDR;
  wire [1:0]vcu_0_M_AXI_DEC1_AWBURST;
  wire [3:0]vcu_0_M_AXI_DEC1_AWCACHE;
  wire [3:0]vcu_0_M_AXI_DEC1_AWID;
  wire [7:0]vcu_0_M_AXI_DEC1_AWLEN;
  wire vcu_0_M_AXI_DEC1_AWLOCK;
  wire [2:0]vcu_0_M_AXI_DEC1_AWPROT;
  wire [3:0]vcu_0_M_AXI_DEC1_AWQOS;
  wire vcu_0_M_AXI_DEC1_AWREADY;
  wire [2:0]vcu_0_M_AXI_DEC1_AWSIZE;
  wire vcu_0_M_AXI_DEC1_AWVALID;
  wire [3:0]vcu_0_M_AXI_DEC1_BID;
  wire vcu_0_M_AXI_DEC1_BREADY;
  wire [1:0]vcu_0_M_AXI_DEC1_BRESP;
  wire vcu_0_M_AXI_DEC1_BVALID;
  wire [127:0]vcu_0_M_AXI_DEC1_RDATA;
  wire [3:0]vcu_0_M_AXI_DEC1_RID;
  wire vcu_0_M_AXI_DEC1_RLAST;
  wire vcu_0_M_AXI_DEC1_RREADY;
  wire [1:0]vcu_0_M_AXI_DEC1_RRESP;
  wire vcu_0_M_AXI_DEC1_RVALID;
  wire [127:0]vcu_0_M_AXI_DEC1_WDATA;
  wire vcu_0_M_AXI_DEC1_WLAST;
  wire vcu_0_M_AXI_DEC1_WREADY;
  wire [15:0]vcu_0_M_AXI_DEC1_WSTRB;
  wire vcu_0_M_AXI_DEC1_WVALID;
  wire [43:0]vcu_0_M_AXI_ENC0_ARADDR;
  wire [1:0]vcu_0_M_AXI_ENC0_ARBURST;
  wire [3:0]vcu_0_M_AXI_ENC0_ARCACHE;
  wire [3:0]vcu_0_M_AXI_ENC0_ARID;
  wire [7:0]vcu_0_M_AXI_ENC0_ARLEN;
  wire vcu_0_M_AXI_ENC0_ARLOCK;
  wire [2:0]vcu_0_M_AXI_ENC0_ARPROT;
  wire [3:0]vcu_0_M_AXI_ENC0_ARQOS;
  wire vcu_0_M_AXI_ENC0_ARREADY;
  wire [2:0]vcu_0_M_AXI_ENC0_ARSIZE;
  wire vcu_0_M_AXI_ENC0_ARVALID;
  wire [43:0]vcu_0_M_AXI_ENC0_AWADDR;
  wire [1:0]vcu_0_M_AXI_ENC0_AWBURST;
  wire [3:0]vcu_0_M_AXI_ENC0_AWCACHE;
  wire [3:0]vcu_0_M_AXI_ENC0_AWID;
  wire [7:0]vcu_0_M_AXI_ENC0_AWLEN;
  wire vcu_0_M_AXI_ENC0_AWLOCK;
  wire [2:0]vcu_0_M_AXI_ENC0_AWPROT;
  wire [3:0]vcu_0_M_AXI_ENC0_AWQOS;
  wire vcu_0_M_AXI_ENC0_AWREADY;
  wire [2:0]vcu_0_M_AXI_ENC0_AWSIZE;
  wire vcu_0_M_AXI_ENC0_AWVALID;
  wire [5:0]vcu_0_M_AXI_ENC0_BID;
  wire vcu_0_M_AXI_ENC0_BREADY;
  wire [1:0]vcu_0_M_AXI_ENC0_BRESP;
  wire vcu_0_M_AXI_ENC0_BVALID;
  wire [127:0]vcu_0_M_AXI_ENC0_RDATA;
  wire [5:0]vcu_0_M_AXI_ENC0_RID;
  wire vcu_0_M_AXI_ENC0_RLAST;
  wire vcu_0_M_AXI_ENC0_RREADY;
  wire [1:0]vcu_0_M_AXI_ENC0_RRESP;
  wire vcu_0_M_AXI_ENC0_RVALID;
  wire [127:0]vcu_0_M_AXI_ENC0_WDATA;
  wire vcu_0_M_AXI_ENC0_WLAST;
  wire vcu_0_M_AXI_ENC0_WREADY;
  wire [15:0]vcu_0_M_AXI_ENC0_WSTRB;
  wire vcu_0_M_AXI_ENC0_WVALID;
  wire [43:0]vcu_0_M_AXI_ENC1_ARADDR;
  wire [1:0]vcu_0_M_AXI_ENC1_ARBURST;
  wire [3:0]vcu_0_M_AXI_ENC1_ARCACHE;
  wire [3:0]vcu_0_M_AXI_ENC1_ARID;
  wire [7:0]vcu_0_M_AXI_ENC1_ARLEN;
  wire vcu_0_M_AXI_ENC1_ARLOCK;
  wire [2:0]vcu_0_M_AXI_ENC1_ARPROT;
  wire [3:0]vcu_0_M_AXI_ENC1_ARQOS;
  wire vcu_0_M_AXI_ENC1_ARREADY;
  wire [2:0]vcu_0_M_AXI_ENC1_ARSIZE;
  wire vcu_0_M_AXI_ENC1_ARVALID;
  wire [43:0]vcu_0_M_AXI_ENC1_AWADDR;
  wire [1:0]vcu_0_M_AXI_ENC1_AWBURST;
  wire [3:0]vcu_0_M_AXI_ENC1_AWCACHE;
  wire [3:0]vcu_0_M_AXI_ENC1_AWID;
  wire [7:0]vcu_0_M_AXI_ENC1_AWLEN;
  wire vcu_0_M_AXI_ENC1_AWLOCK;
  wire [2:0]vcu_0_M_AXI_ENC1_AWPROT;
  wire [3:0]vcu_0_M_AXI_ENC1_AWQOS;
  wire vcu_0_M_AXI_ENC1_AWREADY;
  wire [2:0]vcu_0_M_AXI_ENC1_AWSIZE;
  wire vcu_0_M_AXI_ENC1_AWVALID;
  wire [5:0]vcu_0_M_AXI_ENC1_BID;
  wire vcu_0_M_AXI_ENC1_BREADY;
  wire [1:0]vcu_0_M_AXI_ENC1_BRESP;
  wire vcu_0_M_AXI_ENC1_BVALID;
  wire [127:0]vcu_0_M_AXI_ENC1_RDATA;
  wire [5:0]vcu_0_M_AXI_ENC1_RID;
  wire vcu_0_M_AXI_ENC1_RLAST;
  wire vcu_0_M_AXI_ENC1_RREADY;
  wire [1:0]vcu_0_M_AXI_ENC1_RRESP;
  wire vcu_0_M_AXI_ENC1_RVALID;
  wire [127:0]vcu_0_M_AXI_ENC1_WDATA;
  wire vcu_0_M_AXI_ENC1_WLAST;
  wire vcu_0_M_AXI_ENC1_WREADY;
  wire [15:0]vcu_0_M_AXI_ENC1_WSTRB;
  wire vcu_0_M_AXI_ENC1_WVALID;
  wire [43:0]vcu_0_M_AXI_MCU_ARADDR;
  wire [1:0]vcu_0_M_AXI_MCU_ARBURST;
  wire [3:0]vcu_0_M_AXI_MCU_ARCACHE;
  wire [2:0]vcu_0_M_AXI_MCU_ARID;
  wire [7:0]vcu_0_M_AXI_MCU_ARLEN;
  wire vcu_0_M_AXI_MCU_ARLOCK;
  wire [2:0]vcu_0_M_AXI_MCU_ARPROT;
  wire [3:0]vcu_0_M_AXI_MCU_ARQOS;
  wire vcu_0_M_AXI_MCU_ARREADY;
  wire [2:0]vcu_0_M_AXI_MCU_ARSIZE;
  wire vcu_0_M_AXI_MCU_ARVALID;
  wire [43:0]vcu_0_M_AXI_MCU_AWADDR;
  wire [1:0]vcu_0_M_AXI_MCU_AWBURST;
  wire [3:0]vcu_0_M_AXI_MCU_AWCACHE;
  wire [2:0]vcu_0_M_AXI_MCU_AWID;
  wire [7:0]vcu_0_M_AXI_MCU_AWLEN;
  wire vcu_0_M_AXI_MCU_AWLOCK;
  wire [2:0]vcu_0_M_AXI_MCU_AWPROT;
  wire [3:0]vcu_0_M_AXI_MCU_AWQOS;
  wire vcu_0_M_AXI_MCU_AWREADY;
  wire [2:0]vcu_0_M_AXI_MCU_AWSIZE;
  wire vcu_0_M_AXI_MCU_AWVALID;
  wire [2:0]vcu_0_M_AXI_MCU_BID;
  wire vcu_0_M_AXI_MCU_BREADY;
  wire [1:0]vcu_0_M_AXI_MCU_BRESP;
  wire vcu_0_M_AXI_MCU_BVALID;
  wire [31:0]vcu_0_M_AXI_MCU_RDATA;
  wire [2:0]vcu_0_M_AXI_MCU_RID;
  wire vcu_0_M_AXI_MCU_RLAST;
  wire vcu_0_M_AXI_MCU_RREADY;
  wire [1:0]vcu_0_M_AXI_MCU_RRESP;
  wire vcu_0_M_AXI_MCU_RVALID;
  wire [31:0]vcu_0_M_AXI_MCU_WDATA;
  wire vcu_0_M_AXI_MCU_WLAST;
  wire vcu_0_M_AXI_MCU_WREADY;
  wire [3:0]vcu_0_M_AXI_MCU_WSTRB;
  wire vcu_0_M_AXI_MCU_WVALID;
  wire vcu_0_vcu_host_interrupt;
  wire [1:0]xlconcat_0_dout;
  wire zynq_ultra_ps_e_0_IIC_0_SCL_I;
  wire zynq_ultra_ps_e_0_IIC_0_SCL_O;
  wire zynq_ultra_ps_e_0_IIC_0_SCL_T;
  wire zynq_ultra_ps_e_0_IIC_0_SDA_I;
  wire zynq_ultra_ps_e_0_IIC_0_SDA_O;
  wire zynq_ultra_ps_e_0_IIC_0_SDA_T;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARSIZE;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARVALID;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWSIZE;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWVALID;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BVALID;
  wire [127:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RDATA;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RVALID;
  wire [127:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WDATA;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WREADY;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WSTRB;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WVALID;
  wire [0:0]zynq_ultra_ps_e_0_emio_gpio_o;
  wire zynq_ultra_ps_e_0_pl_clk0;
  wire zynq_ultra_ps_e_0_pl_resetn0;

  assign IIC_0_0_scl_o = zynq_ultra_ps_e_0_IIC_0_SCL_O;
  assign IIC_0_0_scl_t = zynq_ultra_ps_e_0_IIC_0_SCL_T;
  assign IIC_0_0_sda_o = zynq_ultra_ps_e_0_IIC_0_SDA_O;
  assign IIC_0_0_sda_t = zynq_ultra_ps_e_0_IIC_0_SDA_T;
  assign cam_data_0_1 = cam_data_0[7:0];
  assign cam_href_0_1 = cam_href_0;
  assign cam_pclk_0_1 = cam_pclk_0;
  assign cam_pwdn_0[0] = ov5640_dma_top_0_cam_pwdn;
  assign cam_rst_n_0[0] = ov5640_dma_top_0_cam_rst_n;
  assign cam_vsync_0_1 = cam_vsync_0;
  assign zynq_ultra_ps_e_0_IIC_0_SCL_I = IIC_0_0_scl_i;
  assign zynq_ultra_ps_e_0_IIC_0_SDA_I = IIC_0_0_sda_i;
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(zynq_ultra_ps_e_0_pl_clk0),
        .clk_out1(clk_wiz_0_clk_out1),
        .clk_out2(clk_wiz_0_clk_out2));
  design_1_ov5640_dma_top_0_0 ov5640_dma_top_0
       (.aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(rst_ps8_0_99M_peripheral_aresetn),
        .cam_data(cam_data_0_1),
        .cam_href(cam_href_0_1),
        .cam_pclk(cam_pclk_0_1),
        .cam_pwdn(ov5640_dma_top_0_cam_pwdn),
        .cam_rst_n(ov5640_dma_top_0_cam_rst_n),
        .cam_vsync(cam_vsync_0_1),
        .irq(ov5640_dma_top_0_irq),
        .m_axi_awaddr(ov5640_dma_top_0_m_axi_AWADDR),
        .m_axi_awburst(ov5640_dma_top_0_m_axi_AWBURST),
        .m_axi_awlen(ov5640_dma_top_0_m_axi_AWLEN),
        .m_axi_awready(ov5640_dma_top_0_m_axi_AWREADY),
        .m_axi_awsize(ov5640_dma_top_0_m_axi_AWSIZE),
        .m_axi_awvalid(ov5640_dma_top_0_m_axi_AWVALID),
        .m_axi_bready(ov5640_dma_top_0_m_axi_BREADY),
        .m_axi_bresp(ov5640_dma_top_0_m_axi_BRESP),
        .m_axi_bvalid(ov5640_dma_top_0_m_axi_BVALID),
        .m_axi_wdata(ov5640_dma_top_0_m_axi_WDATA),
        .m_axi_wlast(ov5640_dma_top_0_m_axi_WLAST),
        .m_axi_wready(ov5640_dma_top_0_m_axi_WREADY),
        .m_axi_wstrb(ov5640_dma_top_0_m_axi_WSTRB),
        .m_axi_wvalid(ov5640_dma_top_0_m_axi_WVALID),
        .s_axil_araddr(ps8_0_axi_periph_M01_AXI_ARADDR[11:0]),
        .s_axil_arprot(ps8_0_axi_periph_M01_AXI_ARPROT),
        .s_axil_arready(ps8_0_axi_periph_M01_AXI_ARREADY),
        .s_axil_arvalid(ps8_0_axi_periph_M01_AXI_ARVALID),
        .s_axil_awaddr(ps8_0_axi_periph_M01_AXI_AWADDR[11:0]),
        .s_axil_awprot(ps8_0_axi_periph_M01_AXI_AWPROT),
        .s_axil_awready(ps8_0_axi_periph_M01_AXI_AWREADY),
        .s_axil_awvalid(ps8_0_axi_periph_M01_AXI_AWVALID),
        .s_axil_bready(ps8_0_axi_periph_M01_AXI_BREADY),
        .s_axil_bresp(ps8_0_axi_periph_M01_AXI_BRESP),
        .s_axil_bvalid(ps8_0_axi_periph_M01_AXI_BVALID),
        .s_axil_rdata(ps8_0_axi_periph_M01_AXI_RDATA),
        .s_axil_rready(ps8_0_axi_periph_M01_AXI_RREADY),
        .s_axil_rresp(ps8_0_axi_periph_M01_AXI_RRESP),
        .s_axil_rvalid(ps8_0_axi_periph_M01_AXI_RVALID),
        .s_axil_wdata(ps8_0_axi_periph_M01_AXI_WDATA),
        .s_axil_wready(ps8_0_axi_periph_M01_AXI_WREADY),
        .s_axil_wstrb(ps8_0_axi_periph_M01_AXI_WSTRB),
        .s_axil_wvalid(ps8_0_axi_periph_M01_AXI_WVALID));
  design_1_ps8_0_axi_periph_0 ps8_0_axi_periph
       (.ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .ARESETN(rst_ps8_0_99M_peripheral_aresetn),
        .M00_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .M00_ARESETN(rst_ps8_0_99M_peripheral_aresetn),
        .M00_AXI_araddr(ps8_0_axi_periph_M00_AXI_ARADDR),
        .M00_AXI_arprot(ps8_0_axi_periph_M00_AXI_ARPROT),
        .M00_AXI_arready(ps8_0_axi_periph_M00_AXI_ARREADY),
        .M00_AXI_arvalid(ps8_0_axi_periph_M00_AXI_ARVALID),
        .M00_AXI_awaddr(ps8_0_axi_periph_M00_AXI_AWADDR),
        .M00_AXI_awprot(ps8_0_axi_periph_M00_AXI_AWPROT),
        .M00_AXI_awready(ps8_0_axi_periph_M00_AXI_AWREADY),
        .M00_AXI_awvalid(ps8_0_axi_periph_M00_AXI_AWVALID),
        .M00_AXI_bready(ps8_0_axi_periph_M00_AXI_BREADY),
        .M00_AXI_bresp(ps8_0_axi_periph_M00_AXI_BRESP),
        .M00_AXI_bvalid(ps8_0_axi_periph_M00_AXI_BVALID),
        .M00_AXI_rdata(ps8_0_axi_periph_M00_AXI_RDATA),
        .M00_AXI_rready(ps8_0_axi_periph_M00_AXI_RREADY),
        .M00_AXI_rresp(ps8_0_axi_periph_M00_AXI_RRESP),
        .M00_AXI_rvalid(ps8_0_axi_periph_M00_AXI_RVALID),
        .M00_AXI_wdata(ps8_0_axi_periph_M00_AXI_WDATA),
        .M00_AXI_wready(ps8_0_axi_periph_M00_AXI_WREADY),
        .M00_AXI_wstrb(ps8_0_axi_periph_M00_AXI_WSTRB),
        .M00_AXI_wvalid(ps8_0_axi_periph_M00_AXI_WVALID),
        .M01_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .M01_ARESETN(rst_ps8_0_99M_peripheral_aresetn),
        .M01_AXI_araddr(ps8_0_axi_periph_M01_AXI_ARADDR),
        .M01_AXI_arprot(ps8_0_axi_periph_M01_AXI_ARPROT),
        .M01_AXI_arready(ps8_0_axi_periph_M01_AXI_ARREADY),
        .M01_AXI_arvalid(ps8_0_axi_periph_M01_AXI_ARVALID),
        .M01_AXI_awaddr(ps8_0_axi_periph_M01_AXI_AWADDR),
        .M01_AXI_awprot(ps8_0_axi_periph_M01_AXI_AWPROT),
        .M01_AXI_awready(ps8_0_axi_periph_M01_AXI_AWREADY),
        .M01_AXI_awvalid(ps8_0_axi_periph_M01_AXI_AWVALID),
        .M01_AXI_bready(ps8_0_axi_periph_M01_AXI_BREADY),
        .M01_AXI_bresp(ps8_0_axi_periph_M01_AXI_BRESP),
        .M01_AXI_bvalid(ps8_0_axi_periph_M01_AXI_BVALID),
        .M01_AXI_rdata(ps8_0_axi_periph_M01_AXI_RDATA),
        .M01_AXI_rready(ps8_0_axi_periph_M01_AXI_RREADY),
        .M01_AXI_rresp(ps8_0_axi_periph_M01_AXI_RRESP),
        .M01_AXI_rvalid(ps8_0_axi_periph_M01_AXI_RVALID),
        .M01_AXI_wdata(ps8_0_axi_periph_M01_AXI_WDATA),
        .M01_AXI_wready(ps8_0_axi_periph_M01_AXI_WREADY),
        .M01_AXI_wstrb(ps8_0_axi_periph_M01_AXI_WSTRB),
        .M01_AXI_wvalid(ps8_0_axi_periph_M01_AXI_WVALID),
        .S00_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .S00_ARESETN(rst_ps8_0_99M_peripheral_aresetn),
        .S00_AXI_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARADDR),
        .S00_AXI_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARBURST),
        .S00_AXI_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARCACHE),
        .S00_AXI_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARID),
        .S00_AXI_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLEN),
        .S00_AXI_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLOCK),
        .S00_AXI_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARPROT),
        .S00_AXI_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARQOS),
        .S00_AXI_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARREADY),
        .S00_AXI_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARSIZE),
        .S00_AXI_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARVALID),
        .S00_AXI_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWADDR),
        .S00_AXI_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWBURST),
        .S00_AXI_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWCACHE),
        .S00_AXI_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWID),
        .S00_AXI_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLEN),
        .S00_AXI_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLOCK),
        .S00_AXI_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWPROT),
        .S00_AXI_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWQOS),
        .S00_AXI_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWREADY),
        .S00_AXI_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWSIZE),
        .S00_AXI_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWVALID),
        .S00_AXI_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BID),
        .S00_AXI_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BREADY),
        .S00_AXI_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BRESP),
        .S00_AXI_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BVALID),
        .S00_AXI_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RDATA),
        .S00_AXI_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RID),
        .S00_AXI_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RLAST),
        .S00_AXI_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RREADY),
        .S00_AXI_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RRESP),
        .S00_AXI_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RVALID),
        .S00_AXI_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WDATA),
        .S00_AXI_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WLAST),
        .S00_AXI_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WREADY),
        .S00_AXI_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WSTRB),
        .S00_AXI_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WVALID));
  design_1_rst_ps8_0_99M_0 rst_ps8_0_99M
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(zynq_ultra_ps_e_0_pl_resetn0),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_ps8_0_99M_peripheral_aresetn),
        .slowest_sync_clk(zynq_ultra_ps_e_0_pl_clk0));
  design_1_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .M00_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .M00_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .M00_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arqos(smartconnect_0_M00_AXI_ARQOS),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awqos(smartconnect_0_M00_AXI_AWQOS),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .S00_AXI_araddr(vcu_0_M_AXI_DEC1_ARADDR),
        .S00_AXI_arburst(vcu_0_M_AXI_DEC1_ARBURST),
        .S00_AXI_arcache(vcu_0_M_AXI_DEC1_ARCACHE),
        .S00_AXI_arid(vcu_0_M_AXI_DEC1_ARID),
        .S00_AXI_arlen(vcu_0_M_AXI_DEC1_ARLEN),
        .S00_AXI_arlock(vcu_0_M_AXI_DEC1_ARLOCK),
        .S00_AXI_arprot(vcu_0_M_AXI_DEC1_ARPROT),
        .S00_AXI_arqos(vcu_0_M_AXI_DEC1_ARQOS),
        .S00_AXI_arready(vcu_0_M_AXI_DEC1_ARREADY),
        .S00_AXI_arsize(vcu_0_M_AXI_DEC1_ARSIZE),
        .S00_AXI_arvalid(vcu_0_M_AXI_DEC1_ARVALID),
        .S00_AXI_awaddr(vcu_0_M_AXI_DEC1_AWADDR),
        .S00_AXI_awburst(vcu_0_M_AXI_DEC1_AWBURST),
        .S00_AXI_awcache(vcu_0_M_AXI_DEC1_AWCACHE),
        .S00_AXI_awid(vcu_0_M_AXI_DEC1_AWID),
        .S00_AXI_awlen(vcu_0_M_AXI_DEC1_AWLEN),
        .S00_AXI_awlock(vcu_0_M_AXI_DEC1_AWLOCK),
        .S00_AXI_awprot(vcu_0_M_AXI_DEC1_AWPROT),
        .S00_AXI_awqos(vcu_0_M_AXI_DEC1_AWQOS),
        .S00_AXI_awready(vcu_0_M_AXI_DEC1_AWREADY),
        .S00_AXI_awsize(vcu_0_M_AXI_DEC1_AWSIZE),
        .S00_AXI_awvalid(vcu_0_M_AXI_DEC1_AWVALID),
        .S00_AXI_bid(vcu_0_M_AXI_DEC1_BID),
        .S00_AXI_bready(vcu_0_M_AXI_DEC1_BREADY),
        .S00_AXI_bresp(vcu_0_M_AXI_DEC1_BRESP),
        .S00_AXI_bvalid(vcu_0_M_AXI_DEC1_BVALID),
        .S00_AXI_rdata(vcu_0_M_AXI_DEC1_RDATA),
        .S00_AXI_rid(vcu_0_M_AXI_DEC1_RID),
        .S00_AXI_rlast(vcu_0_M_AXI_DEC1_RLAST),
        .S00_AXI_rready(vcu_0_M_AXI_DEC1_RREADY),
        .S00_AXI_rresp(vcu_0_M_AXI_DEC1_RRESP),
        .S00_AXI_rvalid(vcu_0_M_AXI_DEC1_RVALID),
        .S00_AXI_wdata(vcu_0_M_AXI_DEC1_WDATA),
        .S00_AXI_wlast(vcu_0_M_AXI_DEC1_WLAST),
        .S00_AXI_wready(vcu_0_M_AXI_DEC1_WREADY),
        .S00_AXI_wstrb(vcu_0_M_AXI_DEC1_WSTRB),
        .S00_AXI_wvalid(vcu_0_M_AXI_DEC1_WVALID),
        .S01_AXI_araddr(vcu_0_M_AXI_MCU_ARADDR),
        .S01_AXI_arburst(vcu_0_M_AXI_MCU_ARBURST),
        .S01_AXI_arcache(vcu_0_M_AXI_MCU_ARCACHE),
        .S01_AXI_arid(vcu_0_M_AXI_MCU_ARID),
        .S01_AXI_arlen(vcu_0_M_AXI_MCU_ARLEN),
        .S01_AXI_arlock(vcu_0_M_AXI_MCU_ARLOCK),
        .S01_AXI_arprot(vcu_0_M_AXI_MCU_ARPROT),
        .S01_AXI_arqos(vcu_0_M_AXI_MCU_ARQOS),
        .S01_AXI_arready(vcu_0_M_AXI_MCU_ARREADY),
        .S01_AXI_arsize(vcu_0_M_AXI_MCU_ARSIZE),
        .S01_AXI_arvalid(vcu_0_M_AXI_MCU_ARVALID),
        .S01_AXI_awaddr(vcu_0_M_AXI_MCU_AWADDR),
        .S01_AXI_awburst(vcu_0_M_AXI_MCU_AWBURST),
        .S01_AXI_awcache(vcu_0_M_AXI_MCU_AWCACHE),
        .S01_AXI_awid(vcu_0_M_AXI_MCU_AWID),
        .S01_AXI_awlen(vcu_0_M_AXI_MCU_AWLEN),
        .S01_AXI_awlock(vcu_0_M_AXI_MCU_AWLOCK),
        .S01_AXI_awprot(vcu_0_M_AXI_MCU_AWPROT),
        .S01_AXI_awqos(vcu_0_M_AXI_MCU_AWQOS),
        .S01_AXI_awready(vcu_0_M_AXI_MCU_AWREADY),
        .S01_AXI_awsize(vcu_0_M_AXI_MCU_AWSIZE),
        .S01_AXI_awvalid(vcu_0_M_AXI_MCU_AWVALID),
        .S01_AXI_bid(vcu_0_M_AXI_MCU_BID),
        .S01_AXI_bready(vcu_0_M_AXI_MCU_BREADY),
        .S01_AXI_bresp(vcu_0_M_AXI_MCU_BRESP),
        .S01_AXI_bvalid(vcu_0_M_AXI_MCU_BVALID),
        .S01_AXI_rdata(vcu_0_M_AXI_MCU_RDATA),
        .S01_AXI_rid(vcu_0_M_AXI_MCU_RID),
        .S01_AXI_rlast(vcu_0_M_AXI_MCU_RLAST),
        .S01_AXI_rready(vcu_0_M_AXI_MCU_RREADY),
        .S01_AXI_rresp(vcu_0_M_AXI_MCU_RRESP),
        .S01_AXI_rvalid(vcu_0_M_AXI_MCU_RVALID),
        .S01_AXI_wdata(vcu_0_M_AXI_MCU_WDATA),
        .S01_AXI_wlast(vcu_0_M_AXI_MCU_WLAST),
        .S01_AXI_wready(vcu_0_M_AXI_MCU_WREADY),
        .S01_AXI_wstrb(vcu_0_M_AXI_MCU_WSTRB),
        .S01_AXI_wvalid(vcu_0_M_AXI_MCU_WVALID),
        .S02_AXI_awaddr(ov5640_dma_top_0_m_axi_AWADDR),
        .S02_AXI_awburst(ov5640_dma_top_0_m_axi_AWBURST),
        .S02_AXI_awcache({1'b0,1'b0,1'b1,1'b1}),
        .S02_AXI_awlen(ov5640_dma_top_0_m_axi_AWLEN),
        .S02_AXI_awlock(1'b0),
        .S02_AXI_awprot({1'b0,1'b0,1'b0}),
        .S02_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S02_AXI_awready(ov5640_dma_top_0_m_axi_AWREADY),
        .S02_AXI_awsize(ov5640_dma_top_0_m_axi_AWSIZE),
        .S02_AXI_awvalid(ov5640_dma_top_0_m_axi_AWVALID),
        .S02_AXI_bready(ov5640_dma_top_0_m_axi_BREADY),
        .S02_AXI_bresp(ov5640_dma_top_0_m_axi_BRESP),
        .S02_AXI_bvalid(ov5640_dma_top_0_m_axi_BVALID),
        .S02_AXI_wdata(ov5640_dma_top_0_m_axi_WDATA),
        .S02_AXI_wlast(ov5640_dma_top_0_m_axi_WLAST),
        .S02_AXI_wready(ov5640_dma_top_0_m_axi_WREADY),
        .S02_AXI_wstrb(ov5640_dma_top_0_m_axi_WSTRB),
        .S02_AXI_wvalid(ov5640_dma_top_0_m_axi_WVALID),
        .aclk(clk_wiz_0_clk_out2),
        .aclk1(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(rst_ps8_0_99M_peripheral_aresetn));
  design_1_vcu_0_0 vcu_0
       (.m_axi_dec_aclk(clk_wiz_0_clk_out2),
        .m_axi_enc_aclk(clk_wiz_0_clk_out2),
        .m_axi_mcu_aclk(clk_wiz_0_clk_out2),
        .pl_vcu_araddr_axi_lite_apb(ps8_0_axi_periph_M00_AXI_ARADDR[19:0]),
        .pl_vcu_arprot_axi_lite_apb(ps8_0_axi_periph_M00_AXI_ARPROT),
        .pl_vcu_arvalid_axi_lite_apb(ps8_0_axi_periph_M00_AXI_ARVALID),
        .pl_vcu_awaddr_axi_lite_apb(ps8_0_axi_periph_M00_AXI_AWADDR[19:0]),
        .pl_vcu_awprot_axi_lite_apb(ps8_0_axi_periph_M00_AXI_AWPROT),
        .pl_vcu_awvalid_axi_lite_apb(ps8_0_axi_periph_M00_AXI_AWVALID),
        .pl_vcu_bready_axi_lite_apb(ps8_0_axi_periph_M00_AXI_BREADY),
        .pl_vcu_dec_arready0(vcu_0_M_AXI_DEC0_ARREADY),
        .pl_vcu_dec_arready1(vcu_0_M_AXI_DEC1_ARREADY),
        .pl_vcu_dec_awready0(vcu_0_M_AXI_DEC0_AWREADY),
        .pl_vcu_dec_awready1(vcu_0_M_AXI_DEC1_AWREADY),
        .pl_vcu_dec_bid0(vcu_0_M_AXI_DEC0_BID[3:0]),
        .pl_vcu_dec_bid1(vcu_0_M_AXI_DEC1_BID),
        .pl_vcu_dec_bresp0(vcu_0_M_AXI_DEC0_BRESP),
        .pl_vcu_dec_bresp1(vcu_0_M_AXI_DEC1_BRESP),
        .pl_vcu_dec_bvalid0(vcu_0_M_AXI_DEC0_BVALID),
        .pl_vcu_dec_bvalid1(vcu_0_M_AXI_DEC1_BVALID),
        .pl_vcu_dec_rdata0(vcu_0_M_AXI_DEC0_RDATA),
        .pl_vcu_dec_rdata1(vcu_0_M_AXI_DEC1_RDATA),
        .pl_vcu_dec_rid0(vcu_0_M_AXI_DEC0_RID[3:0]),
        .pl_vcu_dec_rid1(vcu_0_M_AXI_DEC1_RID),
        .pl_vcu_dec_rlast0(vcu_0_M_AXI_DEC0_RLAST),
        .pl_vcu_dec_rlast1(vcu_0_M_AXI_DEC1_RLAST),
        .pl_vcu_dec_rresp0(vcu_0_M_AXI_DEC0_RRESP),
        .pl_vcu_dec_rresp1(vcu_0_M_AXI_DEC1_RRESP),
        .pl_vcu_dec_rvalid0(vcu_0_M_AXI_DEC0_RVALID),
        .pl_vcu_dec_rvalid1(vcu_0_M_AXI_DEC1_RVALID),
        .pl_vcu_dec_wready0(vcu_0_M_AXI_DEC0_WREADY),
        .pl_vcu_dec_wready1(vcu_0_M_AXI_DEC1_WREADY),
        .pl_vcu_enc_arready0(vcu_0_M_AXI_ENC0_ARREADY),
        .pl_vcu_enc_arready1(vcu_0_M_AXI_ENC1_ARREADY),
        .pl_vcu_enc_awready0(vcu_0_M_AXI_ENC0_AWREADY),
        .pl_vcu_enc_awready1(vcu_0_M_AXI_ENC1_AWREADY),
        .pl_vcu_enc_bid0(vcu_0_M_AXI_ENC0_BID[3:0]),
        .pl_vcu_enc_bid1(vcu_0_M_AXI_ENC1_BID[3:0]),
        .pl_vcu_enc_bresp0(vcu_0_M_AXI_ENC0_BRESP),
        .pl_vcu_enc_bresp1(vcu_0_M_AXI_ENC1_BRESP),
        .pl_vcu_enc_bvalid0(vcu_0_M_AXI_ENC0_BVALID),
        .pl_vcu_enc_bvalid1(vcu_0_M_AXI_ENC1_BVALID),
        .pl_vcu_enc_rdata0(vcu_0_M_AXI_ENC0_RDATA),
        .pl_vcu_enc_rdata1(vcu_0_M_AXI_ENC1_RDATA),
        .pl_vcu_enc_rid0(vcu_0_M_AXI_ENC0_RID[3:0]),
        .pl_vcu_enc_rid1(vcu_0_M_AXI_ENC1_RID[3:0]),
        .pl_vcu_enc_rlast0(vcu_0_M_AXI_ENC0_RLAST),
        .pl_vcu_enc_rlast1(vcu_0_M_AXI_ENC1_RLAST),
        .pl_vcu_enc_rresp0(vcu_0_M_AXI_ENC0_RRESP),
        .pl_vcu_enc_rresp1(vcu_0_M_AXI_ENC1_RRESP),
        .pl_vcu_enc_rvalid0(vcu_0_M_AXI_ENC0_RVALID),
        .pl_vcu_enc_rvalid1(vcu_0_M_AXI_ENC1_RVALID),
        .pl_vcu_enc_wready0(vcu_0_M_AXI_ENC0_WREADY),
        .pl_vcu_enc_wready1(vcu_0_M_AXI_ENC1_WREADY),
        .pl_vcu_mcu_m_axi_ic_dc_arready(vcu_0_M_AXI_MCU_ARREADY),
        .pl_vcu_mcu_m_axi_ic_dc_awready(vcu_0_M_AXI_MCU_AWREADY),
        .pl_vcu_mcu_m_axi_ic_dc_bid(vcu_0_M_AXI_MCU_BID),
        .pl_vcu_mcu_m_axi_ic_dc_bresp(vcu_0_M_AXI_MCU_BRESP),
        .pl_vcu_mcu_m_axi_ic_dc_bvalid(vcu_0_M_AXI_MCU_BVALID),
        .pl_vcu_mcu_m_axi_ic_dc_rdata(vcu_0_M_AXI_MCU_RDATA),
        .pl_vcu_mcu_m_axi_ic_dc_rid(vcu_0_M_AXI_MCU_RID),
        .pl_vcu_mcu_m_axi_ic_dc_rlast(vcu_0_M_AXI_MCU_RLAST),
        .pl_vcu_mcu_m_axi_ic_dc_rresp(vcu_0_M_AXI_MCU_RRESP),
        .pl_vcu_mcu_m_axi_ic_dc_rvalid(vcu_0_M_AXI_MCU_RVALID),
        .pl_vcu_mcu_m_axi_ic_dc_wready(vcu_0_M_AXI_MCU_WREADY),
        .pl_vcu_rready_axi_lite_apb(ps8_0_axi_periph_M00_AXI_RREADY),
        .pl_vcu_wdata_axi_lite_apb(ps8_0_axi_periph_M00_AXI_WDATA),
        .pl_vcu_wstrb_axi_lite_apb(ps8_0_axi_periph_M00_AXI_WSTRB),
        .pl_vcu_wvalid_axi_lite_apb(ps8_0_axi_periph_M00_AXI_WVALID),
        .pll_ref_clk(clk_wiz_0_clk_out1),
        .s_axi_lite_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .vcu_host_interrupt(vcu_0_vcu_host_interrupt),
        .vcu_pl_arready_axi_lite_apb(ps8_0_axi_periph_M00_AXI_ARREADY),
        .vcu_pl_awready_axi_lite_apb(ps8_0_axi_periph_M00_AXI_AWREADY),
        .vcu_pl_bresp_axi_lite_apb(ps8_0_axi_periph_M00_AXI_BRESP),
        .vcu_pl_bvalid_axi_lite_apb(ps8_0_axi_periph_M00_AXI_BVALID),
        .vcu_pl_dec_araddr0(vcu_0_M_AXI_DEC0_ARADDR),
        .vcu_pl_dec_araddr1(vcu_0_M_AXI_DEC1_ARADDR),
        .vcu_pl_dec_arburst0(vcu_0_M_AXI_DEC0_ARBURST),
        .vcu_pl_dec_arburst1(vcu_0_M_AXI_DEC1_ARBURST),
        .vcu_pl_dec_arcache0(vcu_0_M_AXI_DEC0_ARCACHE),
        .vcu_pl_dec_arcache1(vcu_0_M_AXI_DEC1_ARCACHE),
        .vcu_pl_dec_arid0(vcu_0_M_AXI_DEC0_ARID),
        .vcu_pl_dec_arid1(vcu_0_M_AXI_DEC1_ARID),
        .vcu_pl_dec_arlen0(vcu_0_M_AXI_DEC0_ARLEN),
        .vcu_pl_dec_arlen1(vcu_0_M_AXI_DEC1_ARLEN),
        .vcu_pl_dec_arlock0(vcu_0_M_AXI_DEC0_ARLOCK),
        .vcu_pl_dec_arlock1(vcu_0_M_AXI_DEC1_ARLOCK),
        .vcu_pl_dec_arprot0(vcu_0_M_AXI_DEC0_ARPROT),
        .vcu_pl_dec_arprot1(vcu_0_M_AXI_DEC1_ARPROT),
        .vcu_pl_dec_arqos0(vcu_0_M_AXI_DEC0_ARQOS),
        .vcu_pl_dec_arqos1(vcu_0_M_AXI_DEC1_ARQOS),
        .vcu_pl_dec_arsize0(vcu_0_M_AXI_DEC0_ARSIZE),
        .vcu_pl_dec_arsize1(vcu_0_M_AXI_DEC1_ARSIZE),
        .vcu_pl_dec_arvalid0(vcu_0_M_AXI_DEC0_ARVALID),
        .vcu_pl_dec_arvalid1(vcu_0_M_AXI_DEC1_ARVALID),
        .vcu_pl_dec_awaddr0(vcu_0_M_AXI_DEC0_AWADDR),
        .vcu_pl_dec_awaddr1(vcu_0_M_AXI_DEC1_AWADDR),
        .vcu_pl_dec_awburst0(vcu_0_M_AXI_DEC0_AWBURST),
        .vcu_pl_dec_awburst1(vcu_0_M_AXI_DEC1_AWBURST),
        .vcu_pl_dec_awcache0(vcu_0_M_AXI_DEC0_AWCACHE),
        .vcu_pl_dec_awcache1(vcu_0_M_AXI_DEC1_AWCACHE),
        .vcu_pl_dec_awid0(vcu_0_M_AXI_DEC0_AWID),
        .vcu_pl_dec_awid1(vcu_0_M_AXI_DEC1_AWID),
        .vcu_pl_dec_awlen0(vcu_0_M_AXI_DEC0_AWLEN),
        .vcu_pl_dec_awlen1(vcu_0_M_AXI_DEC1_AWLEN),
        .vcu_pl_dec_awlock0(vcu_0_M_AXI_DEC0_AWLOCK),
        .vcu_pl_dec_awlock1(vcu_0_M_AXI_DEC1_AWLOCK),
        .vcu_pl_dec_awprot0(vcu_0_M_AXI_DEC0_AWPROT),
        .vcu_pl_dec_awprot1(vcu_0_M_AXI_DEC1_AWPROT),
        .vcu_pl_dec_awqos0(vcu_0_M_AXI_DEC0_AWQOS),
        .vcu_pl_dec_awqos1(vcu_0_M_AXI_DEC1_AWQOS),
        .vcu_pl_dec_awsize0(vcu_0_M_AXI_DEC0_AWSIZE),
        .vcu_pl_dec_awsize1(vcu_0_M_AXI_DEC1_AWSIZE),
        .vcu_pl_dec_awvalid0(vcu_0_M_AXI_DEC0_AWVALID),
        .vcu_pl_dec_awvalid1(vcu_0_M_AXI_DEC1_AWVALID),
        .vcu_pl_dec_bready0(vcu_0_M_AXI_DEC0_BREADY),
        .vcu_pl_dec_bready1(vcu_0_M_AXI_DEC1_BREADY),
        .vcu_pl_dec_rready0(vcu_0_M_AXI_DEC0_RREADY),
        .vcu_pl_dec_rready1(vcu_0_M_AXI_DEC1_RREADY),
        .vcu_pl_dec_wdata0(vcu_0_M_AXI_DEC0_WDATA),
        .vcu_pl_dec_wdata1(vcu_0_M_AXI_DEC1_WDATA),
        .vcu_pl_dec_wlast0(vcu_0_M_AXI_DEC0_WLAST),
        .vcu_pl_dec_wlast1(vcu_0_M_AXI_DEC1_WLAST),
        .vcu_pl_dec_wstrb0(vcu_0_M_AXI_DEC0_WSTRB),
        .vcu_pl_dec_wstrb1(vcu_0_M_AXI_DEC1_WSTRB),
        .vcu_pl_dec_wvalid0(vcu_0_M_AXI_DEC0_WVALID),
        .vcu_pl_dec_wvalid1(vcu_0_M_AXI_DEC1_WVALID),
        .vcu_pl_enc_araddr0(vcu_0_M_AXI_ENC0_ARADDR),
        .vcu_pl_enc_araddr1(vcu_0_M_AXI_ENC1_ARADDR),
        .vcu_pl_enc_arburst0(vcu_0_M_AXI_ENC0_ARBURST),
        .vcu_pl_enc_arburst1(vcu_0_M_AXI_ENC1_ARBURST),
        .vcu_pl_enc_arcache0(vcu_0_M_AXI_ENC0_ARCACHE),
        .vcu_pl_enc_arcache1(vcu_0_M_AXI_ENC1_ARCACHE),
        .vcu_pl_enc_arid0(vcu_0_M_AXI_ENC0_ARID),
        .vcu_pl_enc_arid1(vcu_0_M_AXI_ENC1_ARID),
        .vcu_pl_enc_arlen0(vcu_0_M_AXI_ENC0_ARLEN),
        .vcu_pl_enc_arlen1(vcu_0_M_AXI_ENC1_ARLEN),
        .vcu_pl_enc_arlock0(vcu_0_M_AXI_ENC0_ARLOCK),
        .vcu_pl_enc_arlock1(vcu_0_M_AXI_ENC1_ARLOCK),
        .vcu_pl_enc_arprot0(vcu_0_M_AXI_ENC0_ARPROT),
        .vcu_pl_enc_arprot1(vcu_0_M_AXI_ENC1_ARPROT),
        .vcu_pl_enc_arqos0(vcu_0_M_AXI_ENC0_ARQOS),
        .vcu_pl_enc_arqos1(vcu_0_M_AXI_ENC1_ARQOS),
        .vcu_pl_enc_arsize0(vcu_0_M_AXI_ENC0_ARSIZE),
        .vcu_pl_enc_arsize1(vcu_0_M_AXI_ENC1_ARSIZE),
        .vcu_pl_enc_arvalid0(vcu_0_M_AXI_ENC0_ARVALID),
        .vcu_pl_enc_arvalid1(vcu_0_M_AXI_ENC1_ARVALID),
        .vcu_pl_enc_awaddr0(vcu_0_M_AXI_ENC0_AWADDR),
        .vcu_pl_enc_awaddr1(vcu_0_M_AXI_ENC1_AWADDR),
        .vcu_pl_enc_awburst0(vcu_0_M_AXI_ENC0_AWBURST),
        .vcu_pl_enc_awburst1(vcu_0_M_AXI_ENC1_AWBURST),
        .vcu_pl_enc_awcache0(vcu_0_M_AXI_ENC0_AWCACHE),
        .vcu_pl_enc_awcache1(vcu_0_M_AXI_ENC1_AWCACHE),
        .vcu_pl_enc_awid0(vcu_0_M_AXI_ENC0_AWID),
        .vcu_pl_enc_awid1(vcu_0_M_AXI_ENC1_AWID),
        .vcu_pl_enc_awlen0(vcu_0_M_AXI_ENC0_AWLEN),
        .vcu_pl_enc_awlen1(vcu_0_M_AXI_ENC1_AWLEN),
        .vcu_pl_enc_awlock0(vcu_0_M_AXI_ENC0_AWLOCK),
        .vcu_pl_enc_awlock1(vcu_0_M_AXI_ENC1_AWLOCK),
        .vcu_pl_enc_awprot0(vcu_0_M_AXI_ENC0_AWPROT),
        .vcu_pl_enc_awprot1(vcu_0_M_AXI_ENC1_AWPROT),
        .vcu_pl_enc_awqos0(vcu_0_M_AXI_ENC0_AWQOS),
        .vcu_pl_enc_awqos1(vcu_0_M_AXI_ENC1_AWQOS),
        .vcu_pl_enc_awsize0(vcu_0_M_AXI_ENC0_AWSIZE),
        .vcu_pl_enc_awsize1(vcu_0_M_AXI_ENC1_AWSIZE),
        .vcu_pl_enc_awvalid0(vcu_0_M_AXI_ENC0_AWVALID),
        .vcu_pl_enc_awvalid1(vcu_0_M_AXI_ENC1_AWVALID),
        .vcu_pl_enc_bready0(vcu_0_M_AXI_ENC0_BREADY),
        .vcu_pl_enc_bready1(vcu_0_M_AXI_ENC1_BREADY),
        .vcu_pl_enc_rready0(vcu_0_M_AXI_ENC0_RREADY),
        .vcu_pl_enc_rready1(vcu_0_M_AXI_ENC1_RREADY),
        .vcu_pl_enc_wdata0(vcu_0_M_AXI_ENC0_WDATA),
        .vcu_pl_enc_wdata1(vcu_0_M_AXI_ENC1_WDATA),
        .vcu_pl_enc_wlast0(vcu_0_M_AXI_ENC0_WLAST),
        .vcu_pl_enc_wlast1(vcu_0_M_AXI_ENC1_WLAST),
        .vcu_pl_enc_wstrb0(vcu_0_M_AXI_ENC0_WSTRB),
        .vcu_pl_enc_wstrb1(vcu_0_M_AXI_ENC1_WSTRB),
        .vcu_pl_enc_wvalid0(vcu_0_M_AXI_ENC0_WVALID),
        .vcu_pl_enc_wvalid1(vcu_0_M_AXI_ENC1_WVALID),
        .vcu_pl_mcu_m_axi_ic_dc_araddr(vcu_0_M_AXI_MCU_ARADDR),
        .vcu_pl_mcu_m_axi_ic_dc_arburst(vcu_0_M_AXI_MCU_ARBURST),
        .vcu_pl_mcu_m_axi_ic_dc_arcache(vcu_0_M_AXI_MCU_ARCACHE),
        .vcu_pl_mcu_m_axi_ic_dc_arid(vcu_0_M_AXI_MCU_ARID),
        .vcu_pl_mcu_m_axi_ic_dc_arlen(vcu_0_M_AXI_MCU_ARLEN),
        .vcu_pl_mcu_m_axi_ic_dc_arlock(vcu_0_M_AXI_MCU_ARLOCK),
        .vcu_pl_mcu_m_axi_ic_dc_arprot(vcu_0_M_AXI_MCU_ARPROT),
        .vcu_pl_mcu_m_axi_ic_dc_arqos(vcu_0_M_AXI_MCU_ARQOS),
        .vcu_pl_mcu_m_axi_ic_dc_arsize(vcu_0_M_AXI_MCU_ARSIZE),
        .vcu_pl_mcu_m_axi_ic_dc_arvalid(vcu_0_M_AXI_MCU_ARVALID),
        .vcu_pl_mcu_m_axi_ic_dc_awaddr(vcu_0_M_AXI_MCU_AWADDR),
        .vcu_pl_mcu_m_axi_ic_dc_awburst(vcu_0_M_AXI_MCU_AWBURST),
        .vcu_pl_mcu_m_axi_ic_dc_awcache(vcu_0_M_AXI_MCU_AWCACHE),
        .vcu_pl_mcu_m_axi_ic_dc_awid(vcu_0_M_AXI_MCU_AWID),
        .vcu_pl_mcu_m_axi_ic_dc_awlen(vcu_0_M_AXI_MCU_AWLEN),
        .vcu_pl_mcu_m_axi_ic_dc_awlock(vcu_0_M_AXI_MCU_AWLOCK),
        .vcu_pl_mcu_m_axi_ic_dc_awprot(vcu_0_M_AXI_MCU_AWPROT),
        .vcu_pl_mcu_m_axi_ic_dc_awqos(vcu_0_M_AXI_MCU_AWQOS),
        .vcu_pl_mcu_m_axi_ic_dc_awsize(vcu_0_M_AXI_MCU_AWSIZE),
        .vcu_pl_mcu_m_axi_ic_dc_awvalid(vcu_0_M_AXI_MCU_AWVALID),
        .vcu_pl_mcu_m_axi_ic_dc_bready(vcu_0_M_AXI_MCU_BREADY),
        .vcu_pl_mcu_m_axi_ic_dc_rready(vcu_0_M_AXI_MCU_RREADY),
        .vcu_pl_mcu_m_axi_ic_dc_wdata(vcu_0_M_AXI_MCU_WDATA),
        .vcu_pl_mcu_m_axi_ic_dc_wlast(vcu_0_M_AXI_MCU_WLAST),
        .vcu_pl_mcu_m_axi_ic_dc_wstrb(vcu_0_M_AXI_MCU_WSTRB),
        .vcu_pl_mcu_m_axi_ic_dc_wvalid(vcu_0_M_AXI_MCU_WVALID),
        .vcu_pl_rdata_axi_lite_apb(ps8_0_axi_periph_M00_AXI_RDATA),
        .vcu_pl_rresp_axi_lite_apb(ps8_0_axi_periph_M00_AXI_RRESP),
        .vcu_pl_rvalid_axi_lite_apb(ps8_0_axi_periph_M00_AXI_RVALID),
        .vcu_pl_wready_axi_lite_apb(ps8_0_axi_periph_M00_AXI_WREADY),
        .vcu_resetn(zynq_ultra_ps_e_0_emio_gpio_o));
  design_1_xlconcat_0_0 xlconcat_0
       (.In0(vcu_0_vcu_host_interrupt),
        .In1(ov5640_dma_top_0_irq),
        .dout(xlconcat_0_dout));
  design_1_zynq_ultra_ps_e_0_1 zynq_ultra_ps_e_0
       (.emio_gpio_i(1'b0),
        .emio_gpio_o(zynq_ultra_ps_e_0_emio_gpio_o),
        .emio_i2c0_scl_i(zynq_ultra_ps_e_0_IIC_0_SCL_I),
        .emio_i2c0_scl_o(zynq_ultra_ps_e_0_IIC_0_SCL_O),
        .emio_i2c0_scl_t(zynq_ultra_ps_e_0_IIC_0_SCL_T),
        .emio_i2c0_sda_i(zynq_ultra_ps_e_0_IIC_0_SDA_I),
        .emio_i2c0_sda_o(zynq_ultra_ps_e_0_IIC_0_SDA_O),
        .emio_i2c0_sda_t(zynq_ultra_ps_e_0_IIC_0_SDA_T),
        .maxigp0_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARADDR),
        .maxigp0_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARBURST),
        .maxigp0_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARCACHE),
        .maxigp0_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARID),
        .maxigp0_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLEN),
        .maxigp0_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLOCK),
        .maxigp0_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARPROT),
        .maxigp0_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARQOS),
        .maxigp0_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARREADY),
        .maxigp0_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARSIZE),
        .maxigp0_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARVALID),
        .maxigp0_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWADDR),
        .maxigp0_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWBURST),
        .maxigp0_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWCACHE),
        .maxigp0_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWID),
        .maxigp0_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLEN),
        .maxigp0_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLOCK),
        .maxigp0_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWPROT),
        .maxigp0_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWQOS),
        .maxigp0_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWREADY),
        .maxigp0_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWSIZE),
        .maxigp0_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWVALID),
        .maxigp0_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BID),
        .maxigp0_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BREADY),
        .maxigp0_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BRESP),
        .maxigp0_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BVALID),
        .maxigp0_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RDATA),
        .maxigp0_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RID),
        .maxigp0_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RLAST),
        .maxigp0_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RREADY),
        .maxigp0_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RRESP),
        .maxigp0_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RVALID),
        .maxigp0_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WDATA),
        .maxigp0_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WLAST),
        .maxigp0_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WREADY),
        .maxigp0_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WSTRB),
        .maxigp0_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WVALID),
        .maxihpm0_fpd_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .pl_clk0(zynq_ultra_ps_e_0_pl_clk0),
        .pl_ps_irq0(xlconcat_0_dout),
        .pl_resetn0(zynq_ultra_ps_e_0_pl_resetn0),
        .saxigp2_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,vcu_0_M_AXI_ENC0_ARADDR}),
        .saxigp2_arburst(vcu_0_M_AXI_ENC0_ARBURST),
        .saxigp2_arcache(vcu_0_M_AXI_ENC0_ARCACHE),
        .saxigp2_arid({1'b0,1'b0,vcu_0_M_AXI_ENC0_ARID}),
        .saxigp2_arlen(vcu_0_M_AXI_ENC0_ARLEN),
        .saxigp2_arlock(vcu_0_M_AXI_ENC0_ARLOCK),
        .saxigp2_arprot(vcu_0_M_AXI_ENC0_ARPROT),
        .saxigp2_arqos(vcu_0_M_AXI_ENC0_ARQOS),
        .saxigp2_arready(vcu_0_M_AXI_ENC0_ARREADY),
        .saxigp2_arsize(vcu_0_M_AXI_ENC0_ARSIZE),
        .saxigp2_aruser(1'b0),
        .saxigp2_arvalid(vcu_0_M_AXI_ENC0_ARVALID),
        .saxigp2_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,vcu_0_M_AXI_ENC0_AWADDR}),
        .saxigp2_awburst(vcu_0_M_AXI_ENC0_AWBURST),
        .saxigp2_awcache(vcu_0_M_AXI_ENC0_AWCACHE),
        .saxigp2_awid({1'b0,1'b0,vcu_0_M_AXI_ENC0_AWID}),
        .saxigp2_awlen(vcu_0_M_AXI_ENC0_AWLEN),
        .saxigp2_awlock(vcu_0_M_AXI_ENC0_AWLOCK),
        .saxigp2_awprot(vcu_0_M_AXI_ENC0_AWPROT),
        .saxigp2_awqos(vcu_0_M_AXI_ENC0_AWQOS),
        .saxigp2_awready(vcu_0_M_AXI_ENC0_AWREADY),
        .saxigp2_awsize(vcu_0_M_AXI_ENC0_AWSIZE),
        .saxigp2_awuser(1'b0),
        .saxigp2_awvalid(vcu_0_M_AXI_ENC0_AWVALID),
        .saxigp2_bid(vcu_0_M_AXI_ENC0_BID),
        .saxigp2_bready(vcu_0_M_AXI_ENC0_BREADY),
        .saxigp2_bresp(vcu_0_M_AXI_ENC0_BRESP),
        .saxigp2_bvalid(vcu_0_M_AXI_ENC0_BVALID),
        .saxigp2_rdata(vcu_0_M_AXI_ENC0_RDATA),
        .saxigp2_rid(vcu_0_M_AXI_ENC0_RID),
        .saxigp2_rlast(vcu_0_M_AXI_ENC0_RLAST),
        .saxigp2_rready(vcu_0_M_AXI_ENC0_RREADY),
        .saxigp2_rresp(vcu_0_M_AXI_ENC0_RRESP),
        .saxigp2_rvalid(vcu_0_M_AXI_ENC0_RVALID),
        .saxigp2_wdata(vcu_0_M_AXI_ENC0_WDATA),
        .saxigp2_wlast(vcu_0_M_AXI_ENC0_WLAST),
        .saxigp2_wready(vcu_0_M_AXI_ENC0_WREADY),
        .saxigp2_wstrb(vcu_0_M_AXI_ENC0_WSTRB),
        .saxigp2_wvalid(vcu_0_M_AXI_ENC0_WVALID),
        .saxigp3_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,vcu_0_M_AXI_ENC1_ARADDR}),
        .saxigp3_arburst(vcu_0_M_AXI_ENC1_ARBURST),
        .saxigp3_arcache(vcu_0_M_AXI_ENC1_ARCACHE),
        .saxigp3_arid({1'b0,1'b0,vcu_0_M_AXI_ENC1_ARID}),
        .saxigp3_arlen(vcu_0_M_AXI_ENC1_ARLEN),
        .saxigp3_arlock(vcu_0_M_AXI_ENC1_ARLOCK),
        .saxigp3_arprot(vcu_0_M_AXI_ENC1_ARPROT),
        .saxigp3_arqos(vcu_0_M_AXI_ENC1_ARQOS),
        .saxigp3_arready(vcu_0_M_AXI_ENC1_ARREADY),
        .saxigp3_arsize(vcu_0_M_AXI_ENC1_ARSIZE),
        .saxigp3_aruser(1'b0),
        .saxigp3_arvalid(vcu_0_M_AXI_ENC1_ARVALID),
        .saxigp3_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,vcu_0_M_AXI_ENC1_AWADDR}),
        .saxigp3_awburst(vcu_0_M_AXI_ENC1_AWBURST),
        .saxigp3_awcache(vcu_0_M_AXI_ENC1_AWCACHE),
        .saxigp3_awid({1'b0,1'b0,vcu_0_M_AXI_ENC1_AWID}),
        .saxigp3_awlen(vcu_0_M_AXI_ENC1_AWLEN),
        .saxigp3_awlock(vcu_0_M_AXI_ENC1_AWLOCK),
        .saxigp3_awprot(vcu_0_M_AXI_ENC1_AWPROT),
        .saxigp3_awqos(vcu_0_M_AXI_ENC1_AWQOS),
        .saxigp3_awready(vcu_0_M_AXI_ENC1_AWREADY),
        .saxigp3_awsize(vcu_0_M_AXI_ENC1_AWSIZE),
        .saxigp3_awuser(1'b0),
        .saxigp3_awvalid(vcu_0_M_AXI_ENC1_AWVALID),
        .saxigp3_bid(vcu_0_M_AXI_ENC1_BID),
        .saxigp3_bready(vcu_0_M_AXI_ENC1_BREADY),
        .saxigp3_bresp(vcu_0_M_AXI_ENC1_BRESP),
        .saxigp3_bvalid(vcu_0_M_AXI_ENC1_BVALID),
        .saxigp3_rdata(vcu_0_M_AXI_ENC1_RDATA),
        .saxigp3_rid(vcu_0_M_AXI_ENC1_RID),
        .saxigp3_rlast(vcu_0_M_AXI_ENC1_RLAST),
        .saxigp3_rready(vcu_0_M_AXI_ENC1_RREADY),
        .saxigp3_rresp(vcu_0_M_AXI_ENC1_RRESP),
        .saxigp3_rvalid(vcu_0_M_AXI_ENC1_RVALID),
        .saxigp3_wdata(vcu_0_M_AXI_ENC1_WDATA),
        .saxigp3_wlast(vcu_0_M_AXI_ENC1_WLAST),
        .saxigp3_wready(vcu_0_M_AXI_ENC1_WREADY),
        .saxigp3_wstrb(vcu_0_M_AXI_ENC1_WSTRB),
        .saxigp3_wvalid(vcu_0_M_AXI_ENC1_WVALID),
        .saxigp4_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,vcu_0_M_AXI_DEC0_ARADDR}),
        .saxigp4_arburst(vcu_0_M_AXI_DEC0_ARBURST),
        .saxigp4_arcache(vcu_0_M_AXI_DEC0_ARCACHE),
        .saxigp4_arid({1'b0,1'b0,vcu_0_M_AXI_DEC0_ARID}),
        .saxigp4_arlen(vcu_0_M_AXI_DEC0_ARLEN),
        .saxigp4_arlock(vcu_0_M_AXI_DEC0_ARLOCK),
        .saxigp4_arprot(vcu_0_M_AXI_DEC0_ARPROT),
        .saxigp4_arqos(vcu_0_M_AXI_DEC0_ARQOS),
        .saxigp4_arready(vcu_0_M_AXI_DEC0_ARREADY),
        .saxigp4_arsize(vcu_0_M_AXI_DEC0_ARSIZE),
        .saxigp4_aruser(1'b0),
        .saxigp4_arvalid(vcu_0_M_AXI_DEC0_ARVALID),
        .saxigp4_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,vcu_0_M_AXI_DEC0_AWADDR}),
        .saxigp4_awburst(vcu_0_M_AXI_DEC0_AWBURST),
        .saxigp4_awcache(vcu_0_M_AXI_DEC0_AWCACHE),
        .saxigp4_awid({1'b0,1'b0,vcu_0_M_AXI_DEC0_AWID}),
        .saxigp4_awlen(vcu_0_M_AXI_DEC0_AWLEN),
        .saxigp4_awlock(vcu_0_M_AXI_DEC0_AWLOCK),
        .saxigp4_awprot(vcu_0_M_AXI_DEC0_AWPROT),
        .saxigp4_awqos(vcu_0_M_AXI_DEC0_AWQOS),
        .saxigp4_awready(vcu_0_M_AXI_DEC0_AWREADY),
        .saxigp4_awsize(vcu_0_M_AXI_DEC0_AWSIZE),
        .saxigp4_awuser(1'b0),
        .saxigp4_awvalid(vcu_0_M_AXI_DEC0_AWVALID),
        .saxigp4_bid(vcu_0_M_AXI_DEC0_BID),
        .saxigp4_bready(vcu_0_M_AXI_DEC0_BREADY),
        .saxigp4_bresp(vcu_0_M_AXI_DEC0_BRESP),
        .saxigp4_bvalid(vcu_0_M_AXI_DEC0_BVALID),
        .saxigp4_rdata(vcu_0_M_AXI_DEC0_RDATA),
        .saxigp4_rid(vcu_0_M_AXI_DEC0_RID),
        .saxigp4_rlast(vcu_0_M_AXI_DEC0_RLAST),
        .saxigp4_rready(vcu_0_M_AXI_DEC0_RREADY),
        .saxigp4_rresp(vcu_0_M_AXI_DEC0_RRESP),
        .saxigp4_rvalid(vcu_0_M_AXI_DEC0_RVALID),
        .saxigp4_wdata(vcu_0_M_AXI_DEC0_WDATA),
        .saxigp4_wlast(vcu_0_M_AXI_DEC0_WLAST),
        .saxigp4_wready(vcu_0_M_AXI_DEC0_WREADY),
        .saxigp4_wstrb(vcu_0_M_AXI_DEC0_WSTRB),
        .saxigp4_wvalid(vcu_0_M_AXI_DEC0_WVALID),
        .saxigp5_araddr(smartconnect_0_M00_AXI_ARADDR),
        .saxigp5_arburst(smartconnect_0_M00_AXI_ARBURST),
        .saxigp5_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .saxigp5_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp5_arlen(smartconnect_0_M00_AXI_ARLEN),
        .saxigp5_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .saxigp5_arprot(smartconnect_0_M00_AXI_ARPROT),
        .saxigp5_arqos(smartconnect_0_M00_AXI_ARQOS),
        .saxigp5_arready(smartconnect_0_M00_AXI_ARREADY),
        .saxigp5_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .saxigp5_aruser(1'b0),
        .saxigp5_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .saxigp5_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .saxigp5_awburst(smartconnect_0_M00_AXI_AWBURST),
        .saxigp5_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .saxigp5_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp5_awlen(smartconnect_0_M00_AXI_AWLEN),
        .saxigp5_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .saxigp5_awprot(smartconnect_0_M00_AXI_AWPROT),
        .saxigp5_awqos(smartconnect_0_M00_AXI_AWQOS),
        .saxigp5_awready(smartconnect_0_M00_AXI_AWREADY),
        .saxigp5_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .saxigp5_awuser(1'b0),
        .saxigp5_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .saxigp5_bready(smartconnect_0_M00_AXI_BREADY),
        .saxigp5_bresp(smartconnect_0_M00_AXI_BRESP),
        .saxigp5_bvalid(smartconnect_0_M00_AXI_BVALID),
        .saxigp5_rdata(smartconnect_0_M00_AXI_RDATA),
        .saxigp5_rlast(smartconnect_0_M00_AXI_RLAST),
        .saxigp5_rready(smartconnect_0_M00_AXI_RREADY),
        .saxigp5_rresp(smartconnect_0_M00_AXI_RRESP),
        .saxigp5_rvalid(smartconnect_0_M00_AXI_RVALID),
        .saxigp5_wdata(smartconnect_0_M00_AXI_WDATA),
        .saxigp5_wlast(smartconnect_0_M00_AXI_WLAST),
        .saxigp5_wready(smartconnect_0_M00_AXI_WREADY),
        .saxigp5_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .saxigp5_wvalid(smartconnect_0_M00_AXI_WVALID),
        .saxihp0_fpd_aclk(clk_wiz_0_clk_out2),
        .saxihp1_fpd_aclk(clk_wiz_0_clk_out2),
        .saxihp2_fpd_aclk(clk_wiz_0_clk_out2),
        .saxihp3_fpd_aclk(clk_wiz_0_clk_out2));
endmodule

module design_1_ps8_0_axi_periph_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M01_ACLK,
    M01_ARESETN,
    M01_AXI_araddr,
    M01_AXI_arprot,
    M01_AXI_arready,
    M01_AXI_arvalid,
    M01_AXI_awaddr,
    M01_AXI_awprot,
    M01_AXI_awready,
    M01_AXI_awvalid,
    M01_AXI_bready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_rdata,
    M01_AXI_rready,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_wdata,
    M01_AXI_wready,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arid,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awid,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rid,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid);
  input ACLK;
  input ARESETN;
  input M00_ACLK;
  input M00_ARESETN;
  output [39:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  input [0:0]M00_AXI_arready;
  output [0:0]M00_AXI_arvalid;
  output [39:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  input [0:0]M00_AXI_awready;
  output [0:0]M00_AXI_awvalid;
  output [0:0]M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input [0:0]M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output [0:0]M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input [0:0]M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input [0:0]M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output [0:0]M00_AXI_wvalid;
  input M01_ACLK;
  input M01_ARESETN;
  output [39:0]M01_AXI_araddr;
  output [2:0]M01_AXI_arprot;
  input M01_AXI_arready;
  output M01_AXI_arvalid;
  output [39:0]M01_AXI_awaddr;
  output [2:0]M01_AXI_awprot;
  input M01_AXI_awready;
  output M01_AXI_awvalid;
  output M01_AXI_bready;
  input [1:0]M01_AXI_bresp;
  input M01_AXI_bvalid;
  input [31:0]M01_AXI_rdata;
  output M01_AXI_rready;
  input [1:0]M01_AXI_rresp;
  input M01_AXI_rvalid;
  output [31:0]M01_AXI_wdata;
  input M01_AXI_wready;
  output [3:0]M01_AXI_wstrb;
  output M01_AXI_wvalid;
  input S00_ACLK;
  input S00_ARESETN;
  input [39:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [15:0]S00_AXI_arid;
  input [7:0]S00_AXI_arlen;
  input S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [39:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [15:0]S00_AXI_awid;
  input [7:0]S00_AXI_awlen;
  input S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  output [15:0]S00_AXI_bid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [127:0]S00_AXI_rdata;
  output [15:0]S00_AXI_rid;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [127:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [15:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;

  wire [39:0]m00_couplers_to_ps8_0_axi_periph_ARADDR;
  wire [2:0]m00_couplers_to_ps8_0_axi_periph_ARPROT;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_ARREADY;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_ARVALID;
  wire [39:0]m00_couplers_to_ps8_0_axi_periph_AWADDR;
  wire [2:0]m00_couplers_to_ps8_0_axi_periph_AWPROT;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_AWREADY;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_AWVALID;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_BREADY;
  wire [1:0]m00_couplers_to_ps8_0_axi_periph_BRESP;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_BVALID;
  wire [31:0]m00_couplers_to_ps8_0_axi_periph_RDATA;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_RREADY;
  wire [1:0]m00_couplers_to_ps8_0_axi_periph_RRESP;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_RVALID;
  wire [31:0]m00_couplers_to_ps8_0_axi_periph_WDATA;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_WREADY;
  wire [3:0]m00_couplers_to_ps8_0_axi_periph_WSTRB;
  wire [0:0]m00_couplers_to_ps8_0_axi_periph_WVALID;
  wire [39:0]m01_couplers_to_ps8_0_axi_periph_ARADDR;
  wire [2:0]m01_couplers_to_ps8_0_axi_periph_ARPROT;
  wire m01_couplers_to_ps8_0_axi_periph_ARREADY;
  wire m01_couplers_to_ps8_0_axi_periph_ARVALID;
  wire [39:0]m01_couplers_to_ps8_0_axi_periph_AWADDR;
  wire [2:0]m01_couplers_to_ps8_0_axi_periph_AWPROT;
  wire m01_couplers_to_ps8_0_axi_periph_AWREADY;
  wire m01_couplers_to_ps8_0_axi_periph_AWVALID;
  wire m01_couplers_to_ps8_0_axi_periph_BREADY;
  wire [1:0]m01_couplers_to_ps8_0_axi_periph_BRESP;
  wire m01_couplers_to_ps8_0_axi_periph_BVALID;
  wire [31:0]m01_couplers_to_ps8_0_axi_periph_RDATA;
  wire m01_couplers_to_ps8_0_axi_periph_RREADY;
  wire [1:0]m01_couplers_to_ps8_0_axi_periph_RRESP;
  wire m01_couplers_to_ps8_0_axi_periph_RVALID;
  wire [31:0]m01_couplers_to_ps8_0_axi_periph_WDATA;
  wire m01_couplers_to_ps8_0_axi_periph_WREADY;
  wire [3:0]m01_couplers_to_ps8_0_axi_periph_WSTRB;
  wire m01_couplers_to_ps8_0_axi_periph_WVALID;
  wire ps8_0_axi_periph_ACLK_net;
  wire ps8_0_axi_periph_ARESETN_net;
  wire [39:0]ps8_0_axi_periph_to_s00_couplers_ARADDR;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_ARBURST;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_ARCACHE;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_ARID;
  wire [7:0]ps8_0_axi_periph_to_s00_couplers_ARLEN;
  wire ps8_0_axi_periph_to_s00_couplers_ARLOCK;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_ARPROT;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_ARQOS;
  wire ps8_0_axi_periph_to_s00_couplers_ARREADY;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_ARSIZE;
  wire ps8_0_axi_periph_to_s00_couplers_ARVALID;
  wire [39:0]ps8_0_axi_periph_to_s00_couplers_AWADDR;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_AWBURST;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_AWCACHE;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_AWID;
  wire [7:0]ps8_0_axi_periph_to_s00_couplers_AWLEN;
  wire ps8_0_axi_periph_to_s00_couplers_AWLOCK;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_AWPROT;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_AWQOS;
  wire ps8_0_axi_periph_to_s00_couplers_AWREADY;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_AWSIZE;
  wire ps8_0_axi_periph_to_s00_couplers_AWVALID;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_BID;
  wire ps8_0_axi_periph_to_s00_couplers_BREADY;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_BRESP;
  wire ps8_0_axi_periph_to_s00_couplers_BVALID;
  wire [127:0]ps8_0_axi_periph_to_s00_couplers_RDATA;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_RID;
  wire ps8_0_axi_periph_to_s00_couplers_RLAST;
  wire ps8_0_axi_periph_to_s00_couplers_RREADY;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_RRESP;
  wire ps8_0_axi_periph_to_s00_couplers_RVALID;
  wire [127:0]ps8_0_axi_periph_to_s00_couplers_WDATA;
  wire ps8_0_axi_periph_to_s00_couplers_WLAST;
  wire ps8_0_axi_periph_to_s00_couplers_WREADY;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_WSTRB;
  wire ps8_0_axi_periph_to_s00_couplers_WVALID;
  wire [39:0]s00_couplers_to_xbar_ARADDR;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire s00_couplers_to_xbar_ARVALID;
  wire [39:0]s00_couplers_to_xbar_AWADDR;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire s00_couplers_to_xbar_AWVALID;
  wire s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [31:0]s00_couplers_to_xbar_RDATA;
  wire s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [31:0]s00_couplers_to_xbar_WDATA;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [3:0]s00_couplers_to_xbar_WSTRB;
  wire s00_couplers_to_xbar_WVALID;
  wire [39:0]xbar_to_m00_couplers_ARADDR;
  wire [2:0]xbar_to_m00_couplers_ARPROT;
  wire [0:0]xbar_to_m00_couplers_ARREADY;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [39:0]xbar_to_m00_couplers_AWADDR;
  wire [2:0]xbar_to_m00_couplers_AWPROT;
  wire [0:0]xbar_to_m00_couplers_AWREADY;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire [0:0]xbar_to_m00_couplers_BVALID;
  wire [31:0]xbar_to_m00_couplers_RDATA;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire [0:0]xbar_to_m00_couplers_RVALID;
  wire [31:0]xbar_to_m00_couplers_WDATA;
  wire [0:0]xbar_to_m00_couplers_WREADY;
  wire [3:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;
  wire [79:40]xbar_to_m01_couplers_ARADDR;
  wire [5:3]xbar_to_m01_couplers_ARPROT;
  wire xbar_to_m01_couplers_ARREADY;
  wire [1:1]xbar_to_m01_couplers_ARVALID;
  wire [79:40]xbar_to_m01_couplers_AWADDR;
  wire [5:3]xbar_to_m01_couplers_AWPROT;
  wire xbar_to_m01_couplers_AWREADY;
  wire [1:1]xbar_to_m01_couplers_AWVALID;
  wire [1:1]xbar_to_m01_couplers_BREADY;
  wire [1:0]xbar_to_m01_couplers_BRESP;
  wire xbar_to_m01_couplers_BVALID;
  wire [31:0]xbar_to_m01_couplers_RDATA;
  wire [1:1]xbar_to_m01_couplers_RREADY;
  wire [1:0]xbar_to_m01_couplers_RRESP;
  wire xbar_to_m01_couplers_RVALID;
  wire [63:32]xbar_to_m01_couplers_WDATA;
  wire xbar_to_m01_couplers_WREADY;
  wire [7:4]xbar_to_m01_couplers_WSTRB;
  wire [1:1]xbar_to_m01_couplers_WVALID;

  assign M00_AXI_araddr[39:0] = m00_couplers_to_ps8_0_axi_periph_ARADDR;
  assign M00_AXI_arprot[2:0] = m00_couplers_to_ps8_0_axi_periph_ARPROT;
  assign M00_AXI_arvalid[0] = m00_couplers_to_ps8_0_axi_periph_ARVALID;
  assign M00_AXI_awaddr[39:0] = m00_couplers_to_ps8_0_axi_periph_AWADDR;
  assign M00_AXI_awprot[2:0] = m00_couplers_to_ps8_0_axi_periph_AWPROT;
  assign M00_AXI_awvalid[0] = m00_couplers_to_ps8_0_axi_periph_AWVALID;
  assign M00_AXI_bready[0] = m00_couplers_to_ps8_0_axi_periph_BREADY;
  assign M00_AXI_rready[0] = m00_couplers_to_ps8_0_axi_periph_RREADY;
  assign M00_AXI_wdata[31:0] = m00_couplers_to_ps8_0_axi_periph_WDATA;
  assign M00_AXI_wstrb[3:0] = m00_couplers_to_ps8_0_axi_periph_WSTRB;
  assign M00_AXI_wvalid[0] = m00_couplers_to_ps8_0_axi_periph_WVALID;
  assign M01_AXI_araddr[39:0] = m01_couplers_to_ps8_0_axi_periph_ARADDR;
  assign M01_AXI_arprot[2:0] = m01_couplers_to_ps8_0_axi_periph_ARPROT;
  assign M01_AXI_arvalid = m01_couplers_to_ps8_0_axi_periph_ARVALID;
  assign M01_AXI_awaddr[39:0] = m01_couplers_to_ps8_0_axi_periph_AWADDR;
  assign M01_AXI_awprot[2:0] = m01_couplers_to_ps8_0_axi_periph_AWPROT;
  assign M01_AXI_awvalid = m01_couplers_to_ps8_0_axi_periph_AWVALID;
  assign M01_AXI_bready = m01_couplers_to_ps8_0_axi_periph_BREADY;
  assign M01_AXI_rready = m01_couplers_to_ps8_0_axi_periph_RREADY;
  assign M01_AXI_wdata[31:0] = m01_couplers_to_ps8_0_axi_periph_WDATA;
  assign M01_AXI_wstrb[3:0] = m01_couplers_to_ps8_0_axi_periph_WSTRB;
  assign M01_AXI_wvalid = m01_couplers_to_ps8_0_axi_periph_WVALID;
  assign S00_AXI_arready = ps8_0_axi_periph_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = ps8_0_axi_periph_to_s00_couplers_AWREADY;
  assign S00_AXI_bid[15:0] = ps8_0_axi_periph_to_s00_couplers_BID;
  assign S00_AXI_bresp[1:0] = ps8_0_axi_periph_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = ps8_0_axi_periph_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[127:0] = ps8_0_axi_periph_to_s00_couplers_RDATA;
  assign S00_AXI_rid[15:0] = ps8_0_axi_periph_to_s00_couplers_RID;
  assign S00_AXI_rlast = ps8_0_axi_periph_to_s00_couplers_RLAST;
  assign S00_AXI_rresp[1:0] = ps8_0_axi_periph_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = ps8_0_axi_periph_to_s00_couplers_RVALID;
  assign S00_AXI_wready = ps8_0_axi_periph_to_s00_couplers_WREADY;
  assign m00_couplers_to_ps8_0_axi_periph_ARREADY = M00_AXI_arready[0];
  assign m00_couplers_to_ps8_0_axi_periph_AWREADY = M00_AXI_awready[0];
  assign m00_couplers_to_ps8_0_axi_periph_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_ps8_0_axi_periph_BVALID = M00_AXI_bvalid[0];
  assign m00_couplers_to_ps8_0_axi_periph_RDATA = M00_AXI_rdata[31:0];
  assign m00_couplers_to_ps8_0_axi_periph_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_ps8_0_axi_periph_RVALID = M00_AXI_rvalid[0];
  assign m00_couplers_to_ps8_0_axi_periph_WREADY = M00_AXI_wready[0];
  assign m01_couplers_to_ps8_0_axi_periph_ARREADY = M01_AXI_arready;
  assign m01_couplers_to_ps8_0_axi_periph_AWREADY = M01_AXI_awready;
  assign m01_couplers_to_ps8_0_axi_periph_BRESP = M01_AXI_bresp[1:0];
  assign m01_couplers_to_ps8_0_axi_periph_BVALID = M01_AXI_bvalid;
  assign m01_couplers_to_ps8_0_axi_periph_RDATA = M01_AXI_rdata[31:0];
  assign m01_couplers_to_ps8_0_axi_periph_RRESP = M01_AXI_rresp[1:0];
  assign m01_couplers_to_ps8_0_axi_periph_RVALID = M01_AXI_rvalid;
  assign m01_couplers_to_ps8_0_axi_periph_WREADY = M01_AXI_wready;
  assign ps8_0_axi_periph_ACLK_net = ACLK;
  assign ps8_0_axi_periph_ARESETN_net = ARESETN;
  assign ps8_0_axi_periph_to_s00_couplers_ARADDR = S00_AXI_araddr[39:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARBURST = S00_AXI_arburst[1:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARCACHE = S00_AXI_arcache[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARID = S00_AXI_arid[15:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARLEN = S00_AXI_arlen[7:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARLOCK = S00_AXI_arlock;
  assign ps8_0_axi_periph_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARQOS = S00_AXI_arqos[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARSIZE = S00_AXI_arsize[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign ps8_0_axi_periph_to_s00_couplers_AWADDR = S00_AXI_awaddr[39:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWBURST = S00_AXI_awburst[1:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWCACHE = S00_AXI_awcache[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWID = S00_AXI_awid[15:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWLEN = S00_AXI_awlen[7:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWLOCK = S00_AXI_awlock;
  assign ps8_0_axi_periph_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWQOS = S00_AXI_awqos[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWSIZE = S00_AXI_awsize[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign ps8_0_axi_periph_to_s00_couplers_BREADY = S00_AXI_bready;
  assign ps8_0_axi_periph_to_s00_couplers_RREADY = S00_AXI_rready;
  assign ps8_0_axi_periph_to_s00_couplers_WDATA = S00_AXI_wdata[127:0];
  assign ps8_0_axi_periph_to_s00_couplers_WLAST = S00_AXI_wlast;
  assign ps8_0_axi_periph_to_s00_couplers_WSTRB = S00_AXI_wstrb[15:0];
  assign ps8_0_axi_periph_to_s00_couplers_WVALID = S00_AXI_wvalid;
  m00_couplers_imp_QJIMLI m00_couplers
       (.M_ACLK(ps8_0_axi_periph_ACLK_net),
        .M_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .M_AXI_araddr(m00_couplers_to_ps8_0_axi_periph_ARADDR),
        .M_AXI_arprot(m00_couplers_to_ps8_0_axi_periph_ARPROT),
        .M_AXI_arready(m00_couplers_to_ps8_0_axi_periph_ARREADY),
        .M_AXI_arvalid(m00_couplers_to_ps8_0_axi_periph_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_ps8_0_axi_periph_AWADDR),
        .M_AXI_awprot(m00_couplers_to_ps8_0_axi_periph_AWPROT),
        .M_AXI_awready(m00_couplers_to_ps8_0_axi_periph_AWREADY),
        .M_AXI_awvalid(m00_couplers_to_ps8_0_axi_periph_AWVALID),
        .M_AXI_bready(m00_couplers_to_ps8_0_axi_periph_BREADY),
        .M_AXI_bresp(m00_couplers_to_ps8_0_axi_periph_BRESP),
        .M_AXI_bvalid(m00_couplers_to_ps8_0_axi_periph_BVALID),
        .M_AXI_rdata(m00_couplers_to_ps8_0_axi_periph_RDATA),
        .M_AXI_rready(m00_couplers_to_ps8_0_axi_periph_RREADY),
        .M_AXI_rresp(m00_couplers_to_ps8_0_axi_periph_RRESP),
        .M_AXI_rvalid(m00_couplers_to_ps8_0_axi_periph_RVALID),
        .M_AXI_wdata(m00_couplers_to_ps8_0_axi_periph_WDATA),
        .M_AXI_wready(m00_couplers_to_ps8_0_axi_periph_WREADY),
        .M_AXI_wstrb(m00_couplers_to_ps8_0_axi_periph_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_ps8_0_axi_periph_WVALID),
        .S_ACLK(ps8_0_axi_periph_ACLK_net),
        .S_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m00_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m00_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  m01_couplers_imp_1D3SAH3 m01_couplers
       (.M_ACLK(ps8_0_axi_periph_ACLK_net),
        .M_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .M_AXI_araddr(m01_couplers_to_ps8_0_axi_periph_ARADDR),
        .M_AXI_arprot(m01_couplers_to_ps8_0_axi_periph_ARPROT),
        .M_AXI_arready(m01_couplers_to_ps8_0_axi_periph_ARREADY),
        .M_AXI_arvalid(m01_couplers_to_ps8_0_axi_periph_ARVALID),
        .M_AXI_awaddr(m01_couplers_to_ps8_0_axi_periph_AWADDR),
        .M_AXI_awprot(m01_couplers_to_ps8_0_axi_periph_AWPROT),
        .M_AXI_awready(m01_couplers_to_ps8_0_axi_periph_AWREADY),
        .M_AXI_awvalid(m01_couplers_to_ps8_0_axi_periph_AWVALID),
        .M_AXI_bready(m01_couplers_to_ps8_0_axi_periph_BREADY),
        .M_AXI_bresp(m01_couplers_to_ps8_0_axi_periph_BRESP),
        .M_AXI_bvalid(m01_couplers_to_ps8_0_axi_periph_BVALID),
        .M_AXI_rdata(m01_couplers_to_ps8_0_axi_periph_RDATA),
        .M_AXI_rready(m01_couplers_to_ps8_0_axi_periph_RREADY),
        .M_AXI_rresp(m01_couplers_to_ps8_0_axi_periph_RRESP),
        .M_AXI_rvalid(m01_couplers_to_ps8_0_axi_periph_RVALID),
        .M_AXI_wdata(m01_couplers_to_ps8_0_axi_periph_WDATA),
        .M_AXI_wready(m01_couplers_to_ps8_0_axi_periph_WREADY),
        .M_AXI_wstrb(m01_couplers_to_ps8_0_axi_periph_WSTRB),
        .M_AXI_wvalid(m01_couplers_to_ps8_0_axi_periph_WVALID),
        .S_ACLK(ps8_0_axi_periph_ACLK_net),
        .S_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .S_AXI_araddr(xbar_to_m01_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m01_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m01_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m01_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m01_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m01_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m01_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m01_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m01_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m01_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m01_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m01_couplers_RDATA),
        .S_AXI_rready(xbar_to_m01_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m01_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m01_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m01_couplers_WDATA),
        .S_AXI_wready(xbar_to_m01_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m01_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m01_couplers_WVALID));
  s00_couplers_imp_1A7ZMW4 s00_couplers
       (.M_ACLK(ps8_0_axi_periph_ACLK_net),
        .M_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(ps8_0_axi_periph_ACLK_net),
        .S_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .S_AXI_araddr(ps8_0_axi_periph_to_s00_couplers_ARADDR),
        .S_AXI_arburst(ps8_0_axi_periph_to_s00_couplers_ARBURST),
        .S_AXI_arcache(ps8_0_axi_periph_to_s00_couplers_ARCACHE),
        .S_AXI_arid(ps8_0_axi_periph_to_s00_couplers_ARID),
        .S_AXI_arlen(ps8_0_axi_periph_to_s00_couplers_ARLEN),
        .S_AXI_arlock(ps8_0_axi_periph_to_s00_couplers_ARLOCK),
        .S_AXI_arprot(ps8_0_axi_periph_to_s00_couplers_ARPROT),
        .S_AXI_arqos(ps8_0_axi_periph_to_s00_couplers_ARQOS),
        .S_AXI_arready(ps8_0_axi_periph_to_s00_couplers_ARREADY),
        .S_AXI_arsize(ps8_0_axi_periph_to_s00_couplers_ARSIZE),
        .S_AXI_arvalid(ps8_0_axi_periph_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(ps8_0_axi_periph_to_s00_couplers_AWADDR),
        .S_AXI_awburst(ps8_0_axi_periph_to_s00_couplers_AWBURST),
        .S_AXI_awcache(ps8_0_axi_periph_to_s00_couplers_AWCACHE),
        .S_AXI_awid(ps8_0_axi_periph_to_s00_couplers_AWID),
        .S_AXI_awlen(ps8_0_axi_periph_to_s00_couplers_AWLEN),
        .S_AXI_awlock(ps8_0_axi_periph_to_s00_couplers_AWLOCK),
        .S_AXI_awprot(ps8_0_axi_periph_to_s00_couplers_AWPROT),
        .S_AXI_awqos(ps8_0_axi_periph_to_s00_couplers_AWQOS),
        .S_AXI_awready(ps8_0_axi_periph_to_s00_couplers_AWREADY),
        .S_AXI_awsize(ps8_0_axi_periph_to_s00_couplers_AWSIZE),
        .S_AXI_awvalid(ps8_0_axi_periph_to_s00_couplers_AWVALID),
        .S_AXI_bid(ps8_0_axi_periph_to_s00_couplers_BID),
        .S_AXI_bready(ps8_0_axi_periph_to_s00_couplers_BREADY),
        .S_AXI_bresp(ps8_0_axi_periph_to_s00_couplers_BRESP),
        .S_AXI_bvalid(ps8_0_axi_periph_to_s00_couplers_BVALID),
        .S_AXI_rdata(ps8_0_axi_periph_to_s00_couplers_RDATA),
        .S_AXI_rid(ps8_0_axi_periph_to_s00_couplers_RID),
        .S_AXI_rlast(ps8_0_axi_periph_to_s00_couplers_RLAST),
        .S_AXI_rready(ps8_0_axi_periph_to_s00_couplers_RREADY),
        .S_AXI_rresp(ps8_0_axi_periph_to_s00_couplers_RRESP),
        .S_AXI_rvalid(ps8_0_axi_periph_to_s00_couplers_RVALID),
        .S_AXI_wdata(ps8_0_axi_periph_to_s00_couplers_WDATA),
        .S_AXI_wlast(ps8_0_axi_periph_to_s00_couplers_WLAST),
        .S_AXI_wready(ps8_0_axi_periph_to_s00_couplers_WREADY),
        .S_AXI_wstrb(ps8_0_axi_periph_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(ps8_0_axi_periph_to_s00_couplers_WVALID));
  design_1_xbar_1 xbar
       (.aclk(ps8_0_axi_periph_ACLK_net),
        .aresetn(ps8_0_axi_periph_ARESETN_net),
        .m_axi_araddr({xbar_to_m01_couplers_ARADDR,xbar_to_m00_couplers_ARADDR}),
        .m_axi_arprot({xbar_to_m01_couplers_ARPROT,xbar_to_m00_couplers_ARPROT}),
        .m_axi_arready({xbar_to_m01_couplers_ARREADY,xbar_to_m00_couplers_ARREADY}),
        .m_axi_arvalid({xbar_to_m01_couplers_ARVALID,xbar_to_m00_couplers_ARVALID}),
        .m_axi_awaddr({xbar_to_m01_couplers_AWADDR,xbar_to_m00_couplers_AWADDR}),
        .m_axi_awprot({xbar_to_m01_couplers_AWPROT,xbar_to_m00_couplers_AWPROT}),
        .m_axi_awready({xbar_to_m01_couplers_AWREADY,xbar_to_m00_couplers_AWREADY}),
        .m_axi_awvalid({xbar_to_m01_couplers_AWVALID,xbar_to_m00_couplers_AWVALID}),
        .m_axi_bready({xbar_to_m01_couplers_BREADY,xbar_to_m00_couplers_BREADY}),
        .m_axi_bresp({xbar_to_m01_couplers_BRESP,xbar_to_m00_couplers_BRESP}),
        .m_axi_bvalid({xbar_to_m01_couplers_BVALID,xbar_to_m00_couplers_BVALID}),
        .m_axi_rdata({xbar_to_m01_couplers_RDATA,xbar_to_m00_couplers_RDATA}),
        .m_axi_rready({xbar_to_m01_couplers_RREADY,xbar_to_m00_couplers_RREADY}),
        .m_axi_rresp({xbar_to_m01_couplers_RRESP,xbar_to_m00_couplers_RRESP}),
        .m_axi_rvalid({xbar_to_m01_couplers_RVALID,xbar_to_m00_couplers_RVALID}),
        .m_axi_wdata({xbar_to_m01_couplers_WDATA,xbar_to_m00_couplers_WDATA}),
        .m_axi_wready({xbar_to_m01_couplers_WREADY,xbar_to_m00_couplers_WREADY}),
        .m_axi_wstrb({xbar_to_m01_couplers_WSTRB,xbar_to_m00_couplers_WSTRB}),
        .m_axi_wvalid({xbar_to_m01_couplers_WVALID,xbar_to_m00_couplers_WVALID}),
        .s_axi_araddr(s00_couplers_to_xbar_ARADDR),
        .s_axi_arprot(s00_couplers_to_xbar_ARPROT),
        .s_axi_arready(s00_couplers_to_xbar_ARREADY),
        .s_axi_arvalid(s00_couplers_to_xbar_ARVALID),
        .s_axi_awaddr(s00_couplers_to_xbar_AWADDR),
        .s_axi_awprot(s00_couplers_to_xbar_AWPROT),
        .s_axi_awready(s00_couplers_to_xbar_AWREADY),
        .s_axi_awvalid(s00_couplers_to_xbar_AWVALID),
        .s_axi_bready(s00_couplers_to_xbar_BREADY),
        .s_axi_bresp(s00_couplers_to_xbar_BRESP),
        .s_axi_bvalid(s00_couplers_to_xbar_BVALID),
        .s_axi_rdata(s00_couplers_to_xbar_RDATA),
        .s_axi_rready(s00_couplers_to_xbar_RREADY),
        .s_axi_rresp(s00_couplers_to_xbar_RRESP),
        .s_axi_rvalid(s00_couplers_to_xbar_RVALID),
        .s_axi_wdata(s00_couplers_to_xbar_WDATA),
        .s_axi_wready(s00_couplers_to_xbar_WREADY),
        .s_axi_wstrb(s00_couplers_to_xbar_WSTRB),
        .s_axi_wvalid(s00_couplers_to_xbar_WVALID));
endmodule

module m00_couplers_imp_QJIMLI
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [39:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [39:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [39:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [39:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [39:0]m00_couplers_to_m00_couplers_ARADDR;
  wire [2:0]m00_couplers_to_m00_couplers_ARPROT;
  wire [0:0]m00_couplers_to_m00_couplers_ARREADY;
  wire [0:0]m00_couplers_to_m00_couplers_ARVALID;
  wire [39:0]m00_couplers_to_m00_couplers_AWADDR;
  wire [2:0]m00_couplers_to_m00_couplers_AWPROT;
  wire [0:0]m00_couplers_to_m00_couplers_AWREADY;
  wire [0:0]m00_couplers_to_m00_couplers_AWVALID;
  wire [0:0]m00_couplers_to_m00_couplers_BREADY;
  wire [1:0]m00_couplers_to_m00_couplers_BRESP;
  wire [0:0]m00_couplers_to_m00_couplers_BVALID;
  wire [31:0]m00_couplers_to_m00_couplers_RDATA;
  wire [0:0]m00_couplers_to_m00_couplers_RREADY;
  wire [1:0]m00_couplers_to_m00_couplers_RRESP;
  wire [0:0]m00_couplers_to_m00_couplers_RVALID;
  wire [31:0]m00_couplers_to_m00_couplers_WDATA;
  wire [0:0]m00_couplers_to_m00_couplers_WREADY;
  wire [3:0]m00_couplers_to_m00_couplers_WSTRB;
  wire [0:0]m00_couplers_to_m00_couplers_WVALID;

  assign M_AXI_araddr[39:0] = m00_couplers_to_m00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m00_couplers_to_m00_couplers_ARPROT;
  assign M_AXI_arvalid[0] = m00_couplers_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[39:0] = m00_couplers_to_m00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m00_couplers_to_m00_couplers_AWPROT;
  assign M_AXI_awvalid[0] = m00_couplers_to_m00_couplers_AWVALID;
  assign M_AXI_bready[0] = m00_couplers_to_m00_couplers_BREADY;
  assign M_AXI_rready[0] = m00_couplers_to_m00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m00_couplers_to_m00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m00_couplers_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m00_couplers_to_m00_couplers_WVALID;
  assign S_AXI_arready[0] = m00_couplers_to_m00_couplers_ARREADY;
  assign S_AXI_awready[0] = m00_couplers_to_m00_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m00_couplers_to_m00_couplers_BRESP;
  assign S_AXI_bvalid[0] = m00_couplers_to_m00_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m00_couplers_to_m00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m00_couplers_to_m00_couplers_RRESP;
  assign S_AXI_rvalid[0] = m00_couplers_to_m00_couplers_RVALID;
  assign S_AXI_wready[0] = m00_couplers_to_m00_couplers_WREADY;
  assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[39:0];
  assign m00_couplers_to_m00_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready[0];
  assign m00_couplers_to_m00_couplers_ARVALID = S_AXI_arvalid[0];
  assign m00_couplers_to_m00_couplers_AWADDR = S_AXI_awaddr[39:0];
  assign m00_couplers_to_m00_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m00_couplers_to_m00_couplers_AWREADY = M_AXI_awready[0];
  assign m00_couplers_to_m00_couplers_AWVALID = S_AXI_awvalid[0];
  assign m00_couplers_to_m00_couplers_BREADY = S_AXI_bready[0];
  assign m00_couplers_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign m00_couplers_to_m00_couplers_BVALID = M_AXI_bvalid[0];
  assign m00_couplers_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
  assign m00_couplers_to_m00_couplers_RREADY = S_AXI_rready[0];
  assign m00_couplers_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign m00_couplers_to_m00_couplers_RVALID = M_AXI_rvalid[0];
  assign m00_couplers_to_m00_couplers_WDATA = S_AXI_wdata[31:0];
  assign m00_couplers_to_m00_couplers_WREADY = M_AXI_wready[0];
  assign m00_couplers_to_m00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m01_couplers_imp_1D3SAH3
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [39:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [39:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [39:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [39:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [39:0]m01_couplers_to_m01_couplers_ARADDR;
  wire [2:0]m01_couplers_to_m01_couplers_ARPROT;
  wire m01_couplers_to_m01_couplers_ARREADY;
  wire m01_couplers_to_m01_couplers_ARVALID;
  wire [39:0]m01_couplers_to_m01_couplers_AWADDR;
  wire [2:0]m01_couplers_to_m01_couplers_AWPROT;
  wire m01_couplers_to_m01_couplers_AWREADY;
  wire m01_couplers_to_m01_couplers_AWVALID;
  wire m01_couplers_to_m01_couplers_BREADY;
  wire [1:0]m01_couplers_to_m01_couplers_BRESP;
  wire m01_couplers_to_m01_couplers_BVALID;
  wire [31:0]m01_couplers_to_m01_couplers_RDATA;
  wire m01_couplers_to_m01_couplers_RREADY;
  wire [1:0]m01_couplers_to_m01_couplers_RRESP;
  wire m01_couplers_to_m01_couplers_RVALID;
  wire [31:0]m01_couplers_to_m01_couplers_WDATA;
  wire m01_couplers_to_m01_couplers_WREADY;
  wire [3:0]m01_couplers_to_m01_couplers_WSTRB;
  wire m01_couplers_to_m01_couplers_WVALID;

  assign M_AXI_araddr[39:0] = m01_couplers_to_m01_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m01_couplers_to_m01_couplers_ARPROT;
  assign M_AXI_arvalid = m01_couplers_to_m01_couplers_ARVALID;
  assign M_AXI_awaddr[39:0] = m01_couplers_to_m01_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m01_couplers_to_m01_couplers_AWPROT;
  assign M_AXI_awvalid = m01_couplers_to_m01_couplers_AWVALID;
  assign M_AXI_bready = m01_couplers_to_m01_couplers_BREADY;
  assign M_AXI_rready = m01_couplers_to_m01_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m01_couplers_to_m01_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m01_couplers_to_m01_couplers_WSTRB;
  assign M_AXI_wvalid = m01_couplers_to_m01_couplers_WVALID;
  assign S_AXI_arready = m01_couplers_to_m01_couplers_ARREADY;
  assign S_AXI_awready = m01_couplers_to_m01_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m01_couplers_to_m01_couplers_BRESP;
  assign S_AXI_bvalid = m01_couplers_to_m01_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m01_couplers_to_m01_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m01_couplers_to_m01_couplers_RRESP;
  assign S_AXI_rvalid = m01_couplers_to_m01_couplers_RVALID;
  assign S_AXI_wready = m01_couplers_to_m01_couplers_WREADY;
  assign m01_couplers_to_m01_couplers_ARADDR = S_AXI_araddr[39:0];
  assign m01_couplers_to_m01_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m01_couplers_to_m01_couplers_ARREADY = M_AXI_arready;
  assign m01_couplers_to_m01_couplers_ARVALID = S_AXI_arvalid;
  assign m01_couplers_to_m01_couplers_AWADDR = S_AXI_awaddr[39:0];
  assign m01_couplers_to_m01_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m01_couplers_to_m01_couplers_AWREADY = M_AXI_awready;
  assign m01_couplers_to_m01_couplers_AWVALID = S_AXI_awvalid;
  assign m01_couplers_to_m01_couplers_BREADY = S_AXI_bready;
  assign m01_couplers_to_m01_couplers_BRESP = M_AXI_bresp[1:0];
  assign m01_couplers_to_m01_couplers_BVALID = M_AXI_bvalid;
  assign m01_couplers_to_m01_couplers_RDATA = M_AXI_rdata[31:0];
  assign m01_couplers_to_m01_couplers_RREADY = S_AXI_rready;
  assign m01_couplers_to_m01_couplers_RRESP = M_AXI_rresp[1:0];
  assign m01_couplers_to_m01_couplers_RVALID = M_AXI_rvalid;
  assign m01_couplers_to_m01_couplers_WDATA = S_AXI_wdata[31:0];
  assign m01_couplers_to_m01_couplers_WREADY = M_AXI_wready;
  assign m01_couplers_to_m01_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m01_couplers_to_m01_couplers_WVALID = S_AXI_wvalid;
endmodule

module s00_couplers_imp_1A7ZMW4
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [39:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [39:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [39:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [15:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [39:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [15:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [15:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [127:0]S_AXI_rdata;
  output [15:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [127:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [15:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [39:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [39:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [39:0]auto_pc_to_s00_couplers_ARADDR;
  wire [2:0]auto_pc_to_s00_couplers_ARPROT;
  wire auto_pc_to_s00_couplers_ARREADY;
  wire auto_pc_to_s00_couplers_ARVALID;
  wire [39:0]auto_pc_to_s00_couplers_AWADDR;
  wire [2:0]auto_pc_to_s00_couplers_AWPROT;
  wire auto_pc_to_s00_couplers_AWREADY;
  wire auto_pc_to_s00_couplers_AWVALID;
  wire auto_pc_to_s00_couplers_BREADY;
  wire [1:0]auto_pc_to_s00_couplers_BRESP;
  wire auto_pc_to_s00_couplers_BVALID;
  wire [31:0]auto_pc_to_s00_couplers_RDATA;
  wire auto_pc_to_s00_couplers_RREADY;
  wire [1:0]auto_pc_to_s00_couplers_RRESP;
  wire auto_pc_to_s00_couplers_RVALID;
  wire [31:0]auto_pc_to_s00_couplers_WDATA;
  wire auto_pc_to_s00_couplers_WREADY;
  wire [3:0]auto_pc_to_s00_couplers_WSTRB;
  wire auto_pc_to_s00_couplers_WVALID;
  wire [39:0]s00_couplers_to_auto_ds_ARADDR;
  wire [1:0]s00_couplers_to_auto_ds_ARBURST;
  wire [3:0]s00_couplers_to_auto_ds_ARCACHE;
  wire [15:0]s00_couplers_to_auto_ds_ARID;
  wire [7:0]s00_couplers_to_auto_ds_ARLEN;
  wire s00_couplers_to_auto_ds_ARLOCK;
  wire [2:0]s00_couplers_to_auto_ds_ARPROT;
  wire [3:0]s00_couplers_to_auto_ds_ARQOS;
  wire s00_couplers_to_auto_ds_ARREADY;
  wire [2:0]s00_couplers_to_auto_ds_ARSIZE;
  wire s00_couplers_to_auto_ds_ARVALID;
  wire [39:0]s00_couplers_to_auto_ds_AWADDR;
  wire [1:0]s00_couplers_to_auto_ds_AWBURST;
  wire [3:0]s00_couplers_to_auto_ds_AWCACHE;
  wire [15:0]s00_couplers_to_auto_ds_AWID;
  wire [7:0]s00_couplers_to_auto_ds_AWLEN;
  wire s00_couplers_to_auto_ds_AWLOCK;
  wire [2:0]s00_couplers_to_auto_ds_AWPROT;
  wire [3:0]s00_couplers_to_auto_ds_AWQOS;
  wire s00_couplers_to_auto_ds_AWREADY;
  wire [2:0]s00_couplers_to_auto_ds_AWSIZE;
  wire s00_couplers_to_auto_ds_AWVALID;
  wire [15:0]s00_couplers_to_auto_ds_BID;
  wire s00_couplers_to_auto_ds_BREADY;
  wire [1:0]s00_couplers_to_auto_ds_BRESP;
  wire s00_couplers_to_auto_ds_BVALID;
  wire [127:0]s00_couplers_to_auto_ds_RDATA;
  wire [15:0]s00_couplers_to_auto_ds_RID;
  wire s00_couplers_to_auto_ds_RLAST;
  wire s00_couplers_to_auto_ds_RREADY;
  wire [1:0]s00_couplers_to_auto_ds_RRESP;
  wire s00_couplers_to_auto_ds_RVALID;
  wire [127:0]s00_couplers_to_auto_ds_WDATA;
  wire s00_couplers_to_auto_ds_WLAST;
  wire s00_couplers_to_auto_ds_WREADY;
  wire [15:0]s00_couplers_to_auto_ds_WSTRB;
  wire s00_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[39:0] = auto_pc_to_s00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = auto_pc_to_s00_couplers_ARPROT;
  assign M_AXI_arvalid = auto_pc_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[39:0] = auto_pc_to_s00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = auto_pc_to_s00_couplers_AWPROT;
  assign M_AXI_awvalid = auto_pc_to_s00_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_s00_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_s00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_s00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s00_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = s00_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bid[15:0] = s00_couplers_to_auto_ds_BID;
  assign S_AXI_bresp[1:0] = s00_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[127:0] = s00_couplers_to_auto_ds_RDATA;
  assign S_AXI_rid[15:0] = s00_couplers_to_auto_ds_RID;
  assign S_AXI_rlast = s00_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = s00_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_s00_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_s00_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_s00_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_s00_couplers_WREADY = M_AXI_wready;
  assign s00_couplers_to_auto_ds_ARADDR = S_AXI_araddr[39:0];
  assign s00_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_auto_ds_ARID = S_AXI_arid[15:0];
  assign s00_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign s00_couplers_to_auto_ds_ARLOCK = S_AXI_arlock;
  assign s00_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign s00_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[39:0];
  assign s00_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign s00_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign s00_couplers_to_auto_ds_AWID = S_AXI_awid[15:0];
  assign s00_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign s00_couplers_to_auto_ds_AWLOCK = S_AXI_awlock;
  assign s00_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign s00_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign s00_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign s00_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign s00_couplers_to_auto_ds_WDATA = S_AXI_wdata[127:0];
  assign s00_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign s00_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[15:0];
  assign s00_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  design_1_auto_ds_0 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s00_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(s00_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(s00_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arid(s00_couplers_to_auto_ds_ARID),
        .s_axi_arlen(s00_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(s00_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(s00_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(s00_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(s00_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s00_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(s00_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(s00_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(s00_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(s00_couplers_to_auto_ds_AWCACHE),
        .s_axi_awid(s00_couplers_to_auto_ds_AWID),
        .s_axi_awlen(s00_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(s00_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(s00_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(s00_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(s00_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s00_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(s00_couplers_to_auto_ds_AWVALID),
        .s_axi_bid(s00_couplers_to_auto_ds_BID),
        .s_axi_bready(s00_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(s00_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(s00_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(s00_couplers_to_auto_ds_RDATA),
        .s_axi_rid(s00_couplers_to_auto_ds_RID),
        .s_axi_rlast(s00_couplers_to_auto_ds_RLAST),
        .s_axi_rready(s00_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(s00_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(s00_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(s00_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(s00_couplers_to_auto_ds_WLAST),
        .s_axi_wready(s00_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(s00_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(s00_couplers_to_auto_ds_WVALID));
  design_1_auto_pc_0 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_s00_couplers_ARADDR),
        .m_axi_arprot(auto_pc_to_s00_couplers_ARPROT),
        .m_axi_arready(auto_pc_to_s00_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_s00_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_s00_couplers_AWADDR),
        .m_axi_awprot(auto_pc_to_s00_couplers_AWPROT),
        .m_axi_awready(auto_pc_to_s00_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_s00_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_s00_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_s00_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_s00_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_s00_couplers_RDATA),
        .m_axi_rready(auto_pc_to_s00_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_s00_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_s00_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_s00_couplers_WDATA),
        .m_axi_wready(auto_pc_to_s00_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_s00_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_s00_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule
