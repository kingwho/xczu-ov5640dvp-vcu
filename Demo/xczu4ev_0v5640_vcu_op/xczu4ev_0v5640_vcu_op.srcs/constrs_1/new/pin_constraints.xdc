#set_property IOSTANDARD LVCMOS33 [get_ports {CLK[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMD[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {DATA[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {DATA[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {DATA[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {DATA[0]}]
#set_property PACKAGE_PIN AB11 [get_ports {CLK[0]}]
#set_property PACKAGE_PIN AC11 [get_ports {CMD[0]}]
#set_property PACKAGE_PIN AD15 [get_ports {DATA[0]}]
#set_property PACKAGE_PIN AC14 [get_ports {DATA[1]}]
#set_property PACKAGE_PIN AD14 [get_ports {DATA[2]}]
#set_property PACKAGE_PIN AC13 [get_ports {DATA[3]}]

#==================== DVP CMOS Camera Pin Assignment ====================
# I2C
set_property PACKAGE_PIN AD11 [get_ports IIC_0_0_scl_io]
set_property PACKAGE_PIN AD10 [get_ports IIC_0_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports {IIC_0_0_scl_io IIC_0_0_sda_io}]

# DVP Input signals from camera
set_property PACKAGE_PIN AG13 [get_ports cam_vsync_0]
set_property PACKAGE_PIN AC13 [get_ports cam_href_0]
set_property PACKAGE_PIN AA13 [get_ports cam_pclk_0]

## 8bit CAM data bus cam_data_0[7:0]
set_property PACKAGE_PIN Y13  [get_ports cam_data_0[7]]
set_property PACKAGE_PIN AE14 [get_ports cam_data_0[5]]
set_property PACKAGE_PIN AD15 [get_ports cam_data_0[6]]
set_property PACKAGE_PIN AE15 [get_ports cam_data_0[3]]
set_property PACKAGE_PIN AF13 [get_ports cam_data_0[4]]
set_property PACKAGE_PIN AH14 [get_ports cam_data_0[1]]
set_property PACKAGE_PIN AC14 [get_ports cam_data_0[2]]
set_property PACKAGE_PIN AD14 [get_ports cam_data_0[0]]

## DVP Output signals FPGA -> sensor
set_property PACKAGE_PIN AG14 [get_ports cam_rst_n_0]
set_property PACKAGE_PIN W12  [get_ports cam_pwdn_0]

## Set IO standard to 3.3V for all camera related IO
set_property IOSTANDARD LVCMOS33 [get_ports {cam_vsync_0 cam_href_0 cam_pclk_0 cam_data_0[*] cam_rst_n_0 cam_pwdn_0}]

# PCLK 时钟约束（像素时钟，根据你的sensor频率修改，示例25MHz）
create_clock -name cam_pclk -period 40 [get_ports cam_pclk_0]
set_input_delay -max 5 -clock cam_pclk [get_ports cam_data_0[*]]
set_input_delay -max 5 -clock cam_pclk [get_ports cam_href_0]
set_input_delay -max 5 -clock cam_pclk [get_ports cam_vsync_0]

#set_property IOSTANDARD LVCMOS33 [get_ports can0_rx]
#set_property IOSTANDARD LVCMOS33 [get_ports can0_tx]
#set_property PACKAGE_PIN AB11 [get_ports can0_tx]
#set_property PACKAGE_PIN AC11 [get_ports can0_rx]
