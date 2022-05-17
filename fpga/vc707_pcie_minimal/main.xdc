# 100.0MHz GT Reference clock constraint
# PCIe Reference clock location
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

# board reset
set_property PACKAGE_PIN AV40 [get_ports {ext_reset_in_0}]
set_property IOSTANDARD LVCMOS18 [get_ports {ext_reset_in_0}]

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