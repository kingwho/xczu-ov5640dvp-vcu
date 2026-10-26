# aclk {FREQ_HZ 298925582 CLK_DOMAIN design_1_clk_wiz_0_0_clk_out1 PHASE 0.0} aclk1 {FREQ_HZ 99999001 CLK_DOMAIN design_1_zynq_ultra_ps_e_0_1_pl_clk0 PHASE 0.000}
# Clock Domain: design_1_clk_wiz_0_0_clk_out1
create_clock -name aclk -period 3.345 [get_ports aclk]
# Clock Domain: design_1_zynq_ultra_ps_e_0_1_pl_clk0
create_clock -name aclk1 -period 10.000 [get_ports aclk1]
# Generated clocks
