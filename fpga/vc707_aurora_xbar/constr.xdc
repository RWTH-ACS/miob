
#set_property LOC GTHE4_CHANNEL_X0Y10 [get_cells {design_1_i/aurora_8b10b_0/U0/design_1_aurora_8b10b_0_0_core_i/gt_wrapper_i/design_1_aurora_8b10b_0_0_gt_i/inst/gen_gtwizard_gthe4_top.design_1_aurora_8b10b_0_0_gt_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[0].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]
#set_property PACKAGE_PIN AA2 [get_ports {GT_SERIAL_RX_0_rxp[0]}]


# 250.0MHz GT Reference clock constraint
#create_clock -name GT_REFCLK1 -period 4.0	 [get_ports GT_DIFF_REFCLK1_0_clk_p]
# Reference clock location
set_property PACKAGE_PIN A10 [get_ports {GT_DIFF_REFCLK1_0_clk_p[0]}]
set_property PACKAGE_PIN A9 [get_ports {GT_DIFF_REFCLK1_0_clk_n[0]}]


# Transceiver Channel 0 - FPGA FMC1 DP3
# Quad 119 GTXE2_CHANNEL_X1Y27
set_property PACKAGE_PIN A5 [get_ports {GT_SERIAL_RX_0_rxn[0]}]
set_property PACKAGE_PIN A6 [get_ports {GT_SERIAL_RX_0_rxp[0]}]
set_property PACKAGE_PIN B3 [get_ports {GT_SERIAL_TX_0_txn[0]}]
set_property PACKAGE_PIN B4 [get_ports {GT_SERIAL_TX_0_txp[0]}]
# TX_DISABLE LA17_P_CC
set_property PACKAGE_PIN L31 [get_ports {GT_SERIAL_DISABLE_TX_0[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_DISABLE_TX_0[0]}]
# Rate Select LA15_P
set_property PACKAGE_PIN M36 [get_ports {GT_SERIAL_RS_0[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_RS_0[0]}]

# Transceiver Channel 1 - FPGA FMC DP2
# Quad 119 GTXE2_CHANNEL_X1Y26
set_property PACKAGE_PIN B7 [get_ports {GT_SERIAL_RX_1_rxn[0]}]
set_property PACKAGE_PIN B8 [get_ports {GT_SERIAL_RX_1_rxp[0]}]
set_property PACKAGE_PIN C1 [get_ports {GT_SERIAL_TX_1_txn[0]}]
set_property PACKAGE_PIN C2 [get_ports {GT_SERIAL_TX_1_txp[0]}]
# TX_DISABLE LA13_N
set_property PACKAGE_PIN G39 [get_ports {GT_SERIAL_DISABLE_TX_1[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_DISABLE_TX_1[0]}]
# Rate Select LA11_N
set_property PACKAGE_PIN F41 [get_ports {GT_SERIAL_RS_1[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_RS_1[0]}]

# Transceiver Channel 2 - FPGA FMC DP1
# Quad 119 GTXE2_CHANNEL_X1Y25
set_property PACKAGE_PIN C5 [get_ports {GT_SERIAL_RX_2_rxn[0]}]
set_property PACKAGE_PIN C6 [get_ports {GT_SERIAL_RX_2_rxp[0]}]
set_property PACKAGE_PIN D3 [get_ports {GT_SERIAL_TX_2_txn[0]}]
set_property PACKAGE_PIN D4 [get_ports {GT_SERIAL_TX_2_txp[0]}]
# TX_DISABLE LA10_P
set_property PACKAGE_PIN N38 [get_ports {GT_SERIAL_DISABLE_TX_2[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_DISABLE_TX_2[0]}]
# Rate Select LA08_P
set_property PACKAGE_PIN M37 [get_ports {GT_SERIAL_RS_2[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_RS_2[0]}]

# Transceiver Channel 3 - FPGA FMC DP0
# Quad 119 GTXE2_CHANNEL_X1Y24
set_property PACKAGE_PIN D7 [get_ports {GT_SERIAL_RX_3_rxn[0]}]
set_property PACKAGE_PIN D8 [get_ports {GT_SERIAL_RX_3_rxp[0]}]
set_property PACKAGE_PIN E1 [get_ports {GT_SERIAL_TX_3_txn[0]}]
set_property PACKAGE_PIN E2 [get_ports {GT_SERIAL_TX_3_txp[0]}]
# TX_DISABLE LA06_N
set_property PACKAGE_PIN J42 [get_ports {GT_SERIAL_DISABLE_TX_3[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_DISABLE_TX_3[0]}]
# Rate Select LA04_N
set_property PACKAGE_PIN H41 [get_ports {GT_SERIAL_RS_3[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GT_SERIAL_RS_3[0]}]

# CLK Select Switches on FMC Carrier
# P1 connected to FMC1_LA02_P
set_property PACKAGE_PIN P41 [get_ports {CLK_SWITCHES[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CLK_SWITCHES[0]}]
# P2 connected to FMC1_LA02_N
set_property PACKAGE_PIN N41 [get_ports {CLK_SWITCHES[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CLK_SWITCHES[1]}]
# P3 connected to FMC1_LA03_P
set_property PACKAGE_PIN M42 [get_ports {CLK_SWITCHES[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CLK_SWITCHES[2]}]
# P4 connected to FMC1_LA03_N
set_property PACKAGE_PIN L42 [get_ports {CLK_SWITCHES[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CLK_SWITCHES[3]}]



set_false_path -through [get_pins -hier *cdc_to*]




set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets design_1_i/clk_wiz_1/clk_100mhz]


## PCIE Constraints
# 100.0MHz PCIe Reference clock location
set_property PACKAGE_PIN AB8 [get_ports {PCIE_REFCLK_clk_p[0]}]
set_property PACKAGE_PIN AB7 [get_ports {PCIE_REFCLK_clk_n[0]}]

# PCIe Data Signals
set_property PACKAGE_PIN Y3 [get_ports {pcie_7x_mgt_0_rxn[0]}]
set_property PACKAGE_PIN Y4 [get_ports {pcie_7x_mgt_0_rxp[0]}]

set_property PACKAGE_PIN W1 [get_ports {pcie_7x_mgt_0_txn[0]}]
set_property PACKAGE_PIN W2 [get_ports {pcie_7x_mgt_0_txp[0]}]



# PERST PCIe Reset port
set_property PACKAGE_PIN AV35 [get_ports {aux_reset_in_0}]
set_property IOSTANDARD LVCMOS18 [get_ports {aux_reset_in_0}]

# LEDs
set_property PACKAGE_PIN AM39 [get_ports {led_pins_tri_o[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[0]}]
set_property PACKAGE_PIN AN39 [get_ports {led_pins_tri_o[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[1]}]
set_property PACKAGE_PIN AR37 [get_ports {led_pins_tri_o[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[2]}]
set_property PACKAGE_PIN AT37 [get_ports {led_pins_tri_o[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[3]}]
set_property PACKAGE_PIN AR35 [get_ports {led_pins_tri_o[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[4]}]
set_property PACKAGE_PIN AP41 [get_ports {led_pins_tri_o[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[5]}]
set_property PACKAGE_PIN AP42 [get_ports {led_pins_tri_o[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[6]}]
set_property PACKAGE_PIN AU39 [get_ports {led_pins_tri_o[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_pins_tri_o[7]}]
