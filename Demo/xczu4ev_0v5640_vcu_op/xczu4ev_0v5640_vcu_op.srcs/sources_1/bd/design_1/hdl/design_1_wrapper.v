//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Sat Oct 24 15:08:07 2026
//Host        : DESKTOP-6150TMC running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (IIC_0_0_scl_io,
    IIC_0_0_sda_io,
    cam_data_0,
    cam_href_0,
    cam_pclk_0,
    cam_pwdn_0,
    cam_rst_n_0,
    cam_vsync_0);
  inout IIC_0_0_scl_io;
  inout IIC_0_0_sda_io;
  input [7:0]cam_data_0;
  input cam_href_0;
  input cam_pclk_0;
  output [0:0]cam_pwdn_0;
  output [0:0]cam_rst_n_0;
  input cam_vsync_0;

  wire IIC_0_0_scl_i;
  wire IIC_0_0_scl_io;
  wire IIC_0_0_scl_o;
  wire IIC_0_0_scl_t;
  wire IIC_0_0_sda_i;
  wire IIC_0_0_sda_io;
  wire IIC_0_0_sda_o;
  wire IIC_0_0_sda_t;
  wire [7:0]cam_data_0;
  wire cam_href_0;
  wire cam_pclk_0;
  wire [0:0]cam_pwdn_0;
  wire [0:0]cam_rst_n_0;
  wire cam_vsync_0;

  IOBUF IIC_0_0_scl_iobuf
       (.I(IIC_0_0_scl_o),
        .IO(IIC_0_0_scl_io),
        .O(IIC_0_0_scl_i),
        .T(IIC_0_0_scl_t));
  IOBUF IIC_0_0_sda_iobuf
       (.I(IIC_0_0_sda_o),
        .IO(IIC_0_0_sda_io),
        .O(IIC_0_0_sda_i),
        .T(IIC_0_0_sda_t));
  design_1 design_1_i
       (.IIC_0_0_scl_i(IIC_0_0_scl_i),
        .IIC_0_0_scl_o(IIC_0_0_scl_o),
        .IIC_0_0_scl_t(IIC_0_0_scl_t),
        .IIC_0_0_sda_i(IIC_0_0_sda_i),
        .IIC_0_0_sda_o(IIC_0_0_sda_o),
        .IIC_0_0_sda_t(IIC_0_0_sda_t),
        .cam_data_0(cam_data_0),
        .cam_href_0(cam_href_0),
        .cam_pclk_0(cam_pclk_0),
        .cam_pwdn_0(cam_pwdn_0),
        .cam_rst_n_0(cam_rst_n_0),
        .cam_vsync_0(cam_vsync_0));
endmodule
