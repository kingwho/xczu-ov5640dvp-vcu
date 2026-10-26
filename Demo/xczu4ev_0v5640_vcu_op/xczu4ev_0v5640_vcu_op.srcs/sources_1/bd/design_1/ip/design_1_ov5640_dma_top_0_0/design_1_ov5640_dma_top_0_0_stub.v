// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Sat Oct 24 15:10:19 2026
// Host        : DESKTOP-6150TMC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/work_project/FPGA_Prj/xczu4ev_0v5640_vcu_op/xczu4ev_0v5640_vcu_op.srcs/sources_1/bd/design_1/ip/design_1_ov5640_dma_top_0_0/design_1_ov5640_dma_top_0_0_stub.v
// Design      : design_1_ov5640_dma_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu4ev-sfvc784-1-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ov5640_dma_top,Vivado 2020.2" *)
module design_1_ov5640_dma_top_0_0(aclk, aresetn, s_axil_awaddr, s_axil_awprot, 
  s_axil_awvalid, s_axil_awready, s_axil_wdata, s_axil_wstrb, s_axil_wvalid, s_axil_wready, 
  s_axil_bresp, s_axil_bvalid, s_axil_bready, s_axil_araddr, s_axil_arprot, s_axil_arvalid, 
  s_axil_arready, s_axil_rdata, s_axil_rresp, s_axil_rvalid, s_axil_rready, m_axi_awaddr, 
  m_axi_awlen, m_axi_awsize, m_axi_awburst, m_axi_awvalid, m_axi_awready, m_axi_wdata, 
  m_axi_wstrb, m_axi_wlast, m_axi_wvalid, m_axi_wready, m_axi_bresp, m_axi_bvalid, 
  m_axi_bready, irq, cam_pclk, cam_vsync, cam_href, cam_data, cam_rst_n, cam_pwdn)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axil_awaddr[11:0],s_axil_awprot[2:0],s_axil_awvalid,s_axil_awready,s_axil_wdata[31:0],s_axil_wstrb[3:0],s_axil_wvalid,s_axil_wready,s_axil_bresp[1:0],s_axil_bvalid,s_axil_bready,s_axil_araddr[11:0],s_axil_arprot[2:0],s_axil_arvalid,s_axil_arready,s_axil_rdata[31:0],s_axil_rresp[1:0],s_axil_rvalid,s_axil_rready,m_axi_awaddr[31:0],m_axi_awlen[7:0],m_axi_awsize[2:0],m_axi_awburst[1:0],m_axi_awvalid,m_axi_awready,m_axi_wdata[63:0],m_axi_wstrb[7:0],m_axi_wlast,m_axi_wvalid,m_axi_wready,m_axi_bresp[1:0],m_axi_bvalid,m_axi_bready,irq,cam_pclk,cam_vsync,cam_href,cam_data[7:0],cam_rst_n,cam_pwdn" */;
  input aclk;
  input aresetn;
  input [11:0]s_axil_awaddr;
  input [2:0]s_axil_awprot;
  input s_axil_awvalid;
  output s_axil_awready;
  input [31:0]s_axil_wdata;
  input [3:0]s_axil_wstrb;
  input s_axil_wvalid;
  output s_axil_wready;
  output [1:0]s_axil_bresp;
  output s_axil_bvalid;
  input s_axil_bready;
  input [11:0]s_axil_araddr;
  input [2:0]s_axil_arprot;
  input s_axil_arvalid;
  output s_axil_arready;
  output [31:0]s_axil_rdata;
  output [1:0]s_axil_rresp;
  output s_axil_rvalid;
  input s_axil_rready;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output m_axi_awvalid;
  input m_axi_awready;
  output [63:0]m_axi_wdata;
  output [7:0]m_axi_wstrb;
  output m_axi_wlast;
  output m_axi_wvalid;
  input m_axi_wready;
  input [1:0]m_axi_bresp;
  input m_axi_bvalid;
  output m_axi_bready;
  output irq;
  input cam_pclk;
  input cam_vsync;
  input cam_href;
  input [7:0]cam_data;
  output cam_rst_n;
  output cam_pwdn;
endmodule
