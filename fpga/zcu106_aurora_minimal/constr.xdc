
#set_property LOC GTHE4_CHANNEL_X0Y10 [get_cells {design_1_i/aurora_8b10b_0/U0/design_1_aurora_8b10b_0_0_core_i/gt_wrapper_i/design_1_aurora_8b10b_0_0_gt_i/inst/gen_gtwizard_gthe4_top.design_1_aurora_8b10b_0_0_gt_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[0].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]
#set_property PACKAGE_PIN AA2 [get_ports {GT_SERIAL_RX_0_rxp[0]}]


# 250.0MHz GT Reference clock constraint
#create_clock -name GT_REFCLK1 -period 4.0	 [get_ports GT_DIFF_REFCLK1_0_clk_p]
# Reference clock location
set_property PACKAGE_PIN W9 [get_ports GT_DIFF_REFCLK1_0_clk_n]
set_property PACKAGE_PIN W10 [get_ports GT_DIFF_REFCLK1_0_clk_p]


set_property PACKAGE_PIN AA2 [get_ports {GT_SERIAL_RX_0_rxp[0]}]
set_property PACKAGE_PIN AA1 [get_ports {GT_SERIAL_RX_0_rxn[0]}]
set_property PACKAGE_PIN Y4 [get_ports {GT_SERIAL_TX_0_txp[0]}]
set_property PACKAGE_PIN Y3 [get_ports {GT_SERIAL_TX_0_txn[0]}]

set_false_path -through [get_pins -hier *cdc_to*]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets design_1_i/clk_wiz_1/clk_100mhz]
