
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# aurora_demo, config_timer, dinoif_dac, dinoif_fast_nologic, registerif, axi_read_cache, axi_pcie_intc

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx485tffg1761-2
   set_property BOARD_PART xilinx.com:vc707:part0:1.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ./projects/miob/fpga/vc707_aurora_xbar

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2030 -severity "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_gid_msg -ssname BD::TCL -id 2031 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_gid_msg -ssname BD::TCL -id 2032 -severity "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2033 -severity "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2034 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2035 -severity "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_gid_msg -ssname BD::TCL -id 2036 -severity "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2037 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_gid_msg -ssname BD::TCL -id 2038 -severity "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:aurora_8b10b:11.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axi_clock_converter:2.1\
xilinx.com:ip:axi_iic:2.1\
xilinx.com:ip:axis_subset_converter:1.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:floating_point:7.1\
xilinx.com:ip:axi_pcie:2.9\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
aurora_demo\
config_timer\
dinoif_dac\
dinoif_fast_nologic\
registerif\
axi_read_cache\
axi_pcie_intc\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: pcie_interrupts
proc create_hier_cell_pcie_interrupts { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pcie_interrupts() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I INTX_MSI_Grant
  create_bd_pin -dir O INTX_MSI_Request
  create_bd_pin -dir I -from 0 -to 0 In2
  create_bd_pin -dir I MSI_Enable
  create_bd_pin -dir O -from 4 -to 0 MSI_Vector_Num
  create_bd_pin -dir I -from 2 -to 0 MSI_Vector_Width
  create_bd_pin -dir I -from 0 -to 0 intr_dma_mm2s
  create_bd_pin -dir I -from 0 -to 0 intr_dma_s2mm
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_pcie_intc_0, and set properties
  set block_name axi_pcie_intc
  set block_cell_name axi_pcie_intc_0
  if { [catch {set axi_pcie_intc_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_pcie_intc_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_0

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_2

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins s_axi] [get_bd_intf_pins axi_pcie_intc_0/s_axi]

  # Create port connections
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins intr_dma_mm2s] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins intr_dma_s2mm] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_pcie_0_INTX_MSI_Grant [get_bd_pins INTX_MSI_Grant] [get_bd_pins axi_pcie_intc_0/INTX_MSI_Grant]
  connect_bd_net -net axi_pcie_0_MSI_Vector_Width [get_bd_pins MSI_Vector_Width] [get_bd_pins axi_pcie_intc_0/MSI_Vector_Width]
  connect_bd_net -net axi_pcie_0_MSI_enable [get_bd_pins MSI_Enable] [get_bd_pins axi_pcie_intc_0/MSI_Enable]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins s_axi_aclk] [get_bd_pins axi_pcie_intc_0/s_axi_aclk]
  connect_bd_net -net axi_pcie_intc_0_INTX_MSI_Request [get_bd_pins INTX_MSI_Request] [get_bd_pins axi_pcie_intc_0/INTX_MSI_Request]
  connect_bd_net -net axi_pcie_intc_0_MSI_Vector_Num [get_bd_pins MSI_Vector_Num] [get_bd_pins axi_pcie_intc_0/MSI_Vector_Num]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_pcie_intc_0/s_axi_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_pcie_intc_0/intr] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins xlconcat_0/In3] [get_bd_pins xlconstant_2/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pcie
proc create_hier_cell_pcie { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pcie() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REFCLK

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:aximm_rtl:1.0 SLOT_2_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTL

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_intc


  # Create pins
  create_bd_pin -dir I -from 0 -to 0 In2
  create_bd_pin -dir O -type clk axi_ctl_aclk_out
  create_bd_pin -dir I -from 0 -to 0 intr_dma_mm2s
  create_bd_pin -dir I -from 0 -to 0 intr_dma_s2mm
  create_bd_pin -dir O mmcm_lock
  create_bd_pin -dir O -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_pcie_0, and set properties
  set axi_pcie_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_pcie:2.9 axi_pcie_0 ]
  set_property -dict [ list \
   CONFIG.AXIBAR2PCIEBAR_0 {0x00000000} \
   CONFIG.BAR0_SCALE {Megabytes} \
   CONFIG.BAR0_SIZE {1} \
   CONFIG.DEVICE_ID {0x7021} \
   CONFIG.MAX_LINK_SPEED {5.0_GT/s} \
   CONFIG.M_AXI_DATA_WIDTH {64} \
   CONFIG.NUM_MSI_REQ {4} \
   CONFIG.S_AXI_DATA_WIDTH {64} \
   CONFIG.XLNX_REF_BOARD {VC707} \
 ] $axi_pcie_0

  # Create instance: pcie_interrupts
  create_hier_cell_pcie_interrupts $hier_obj pcie_interrupts

  # Create instance: system_ila_1, and set properties
  set system_ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_1 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {195.5} \
   CONFIG.C_DATA_DEPTH {16384} \
   CONFIG.C_MON_TYPE {MIX} \
   CONFIG.C_NUM_MONITOR_SLOTS {3} \
   CONFIG.C_NUM_OF_PROBES {8} \
   CONFIG.C_SLOT {2} \
   CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_1

  # Create instance: util_ds_buf_1, and set properties
  set util_ds_buf_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_1 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_1

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_pins PCIE_REFCLK] [get_bd_intf_pins util_ds_buf_1/CLK_IN_D]
  connect_bd_intf_net -intf_net Conn [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_pcie_0/S_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn] [get_bd_intf_pins S_AXI] [get_bd_intf_pins system_ila_1/SLOT_1_AXI]
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins SLOT_2_AXI] [get_bd_intf_pins system_ila_1/SLOT_2_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins s_axi_intc] [get_bd_intf_pins pcie_interrupts/s_axi]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins S_AXI_CTL] [get_bd_intf_pins axi_pcie_0/S_AXI_CTL]
  connect_bd_intf_net -intf_net axi_pcie_0_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_pcie_0/M_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axi_pcie_0_M_AXI] [get_bd_intf_pins M_AXI] [get_bd_intf_pins system_ila_1/SLOT_0_AXI]
  connect_bd_intf_net -intf_net axi_pcie_0_pcie_7x_mgt [get_bd_intf_pins pcie_7x_mgt_0] [get_bd_intf_pins axi_pcie_0/pcie_7x_mgt]

  # Create port connections
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins pcie_interrupts/In2] [get_bd_pins system_ila_1/probe2]
  connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins intr_dma_mm2s] [get_bd_pins pcie_interrupts/intr_dma_mm2s] [get_bd_pins system_ila_1/probe0]
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins intr_dma_s2mm] [get_bd_pins pcie_interrupts/intr_dma_s2mm] [get_bd_pins system_ila_1/probe1]
  connect_bd_net -net axi_pcie_0_INTX_MSI_Grant [get_bd_pins axi_pcie_0/INTX_MSI_Grant] [get_bd_pins pcie_interrupts/INTX_MSI_Grant] [get_bd_pins system_ila_1/probe5]
  connect_bd_net -net axi_pcie_0_MSI_Vector_Width [get_bd_pins axi_pcie_0/MSI_Vector_Width] [get_bd_pins pcie_interrupts/MSI_Vector_Width] [get_bd_pins system_ila_1/probe7]
  connect_bd_net -net axi_pcie_0_MSI_enable [get_bd_pins axi_pcie_0/MSI_enable] [get_bd_pins pcie_interrupts/MSI_Enable] [get_bd_pins system_ila_1/probe6]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins s_axi_aclk] [get_bd_pins axi_pcie_0/axi_aclk_out] [get_bd_pins pcie_interrupts/s_axi_aclk] [get_bd_pins system_ila_1/clk]
  connect_bd_net -net axi_pcie_0_axi_ctl_aclk_out [get_bd_pins axi_ctl_aclk_out] [get_bd_pins axi_pcie_0/axi_ctl_aclk_out]
  connect_bd_net -net axi_pcie_0_mmcm_lock [get_bd_pins mmcm_lock] [get_bd_pins axi_pcie_0/mmcm_lock]
  connect_bd_net -net axi_pcie_intc_0_INTX_MSI_Request [get_bd_pins axi_pcie_0/INTX_MSI_Request] [get_bd_pins pcie_interrupts/INTX_MSI_Request] [get_bd_pins system_ila_1/probe4]
  connect_bd_net -net axi_pcie_intc_0_MSI_Vector_Num [get_bd_pins axi_pcie_0/MSI_Vector_Num] [get_bd_pins pcie_interrupts/MSI_Vector_Num] [get_bd_pins system_ila_1/probe3]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_pcie_0/axi_aresetn] [get_bd_pins pcie_interrupts/s_axi_aresetn] [get_bd_pins system_ila_1/resetn]
  connect_bd_net -net util_ds_buf_1_IBUF_OUT [get_bd_pins axi_pcie_0/REFCLK] [get_bd_pins util_ds_buf_1/IBUF_OUT]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: scale_offset
proc create_hier_cell_scale_offset { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_scale_offset() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_RESULT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_A


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst resetn
  create_bd_pin -dir I -from 31 -to 0 s_axis_b_tdata
  create_bd_pin -dir I -from 31 -to 0 s_axis_c_tdata

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.DEFAULT_TLAST {1} \
   CONFIG.M_HAS_TKEEP {1} \
   CONFIG.M_HAS_TLAST {1} \
   CONFIG.M_HAS_TREADY {0} \
   CONFIG.M_TDATA_NUM_BYTES {4} \
   CONFIG.S_HAS_TKEEP {0} \
   CONFIG.S_HAS_TLAST {0} \
   CONFIG.S_HAS_TREADY {0} \
   CONFIG.S_TDATA_NUM_BYTES {4} \
   CONFIG.TDATA_REMAP {tdata[31:0]} \
   CONFIG.TKEEP_REMAP {4'b1111} \
   CONFIG.TLAST_REMAP {tlast[0]} \
 ] $axis_subset_converter_0

  # Create instance: floating_point_0, and set properties
  set floating_point_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0 ]
  set_property -dict [ list \
   CONFIG.A_Precision_Type {Custom} \
   CONFIG.C_A_Exponent_Width {16} \
   CONFIG.C_A_Fraction_Width {0} \
   CONFIG.C_Accum_Input_Msb {32} \
   CONFIG.C_Accum_Lsb {-31} \
   CONFIG.C_Accum_Msb {32} \
   CONFIG.C_Latency {4} \
   CONFIG.C_Mult_Usage {No_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {NonBlocking} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Maximum_Latency {false} \
   CONFIG.Operation_Type {Fixed_to_float} \
   CONFIG.Result_Precision_Type {Single} \
 ] $floating_point_0

  # Create instance: floating_point_1, and set properties
  set floating_point_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_1 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {4} \
   CONFIG.C_Mult_Usage {Medium_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {NonBlocking} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Maximum_Latency {false} \
   CONFIG.Operation_Type {FMA} \
   CONFIG.Result_Precision_Type {Single} \
 ] $floating_point_1

  # Create instance: xlconstant_6, and set properties
  set xlconstant_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_6 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins M_AXIS_RESULT] [get_bd_intf_pins axis_subset_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net dinoif_fast_0_M00_AXIS [get_bd_intf_pins S_AXIS_A] [get_bd_intf_pins floating_point_0/S_AXIS_A]
  connect_bd_intf_net -intf_net floating_point_0_M_AXIS_RESULT [get_bd_intf_pins floating_point_0/M_AXIS_RESULT] [get_bd_intf_pins floating_point_1/S_AXIS_A]
  connect_bd_intf_net -intf_net floating_point_1_M_AXIS_RESULT [get_bd_intf_pins axis_subset_converter_0/S_AXIS] [get_bd_intf_pins floating_point_1/M_AXIS_RESULT]

  # Create port connections
  connect_bd_net -net clk_wiz_1_clk_100mhz [get_bd_pins aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins floating_point_0/aclk] [get_bd_pins floating_point_1/aclk]
  connect_bd_net -net resetn_1 [get_bd_pins resetn] [get_bd_pins axis_subset_converter_0/aresetn]
  connect_bd_net -net s_axis_b_tdata_1 [get_bd_pins s_axis_b_tdata] [get_bd_pins floating_point_1/s_axis_b_tdata]
  connect_bd_net -net s_axis_c_tdata_1 [get_bd_pins s_axis_c_tdata] [get_bd_pins floating_point_1/s_axis_c_tdata]
  connect_bd_net -net xlconstant_6_dout [get_bd_pins floating_point_1/s_axis_b_tvalid] [get_bd_pins floating_point_1/s_axis_c_tvalid] [get_bd_pins xlconstant_6/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dma_pcie
proc create_hier_cell_dma_pcie { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_dma_pcie() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_MM2S

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REFCLK

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_S2MM

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt_0


  # Create pins
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -from 0 -to 0 In2
  create_bd_pin -dir I -type rst M01_ARESETN
  create_bd_pin -dir O -type clk axi_ctl_aclk_out
  create_bd_pin -dir O mmcm_lock
  create_bd_pin -dir O -type clk s_axi_aclk

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_include_sg {1} \
   CONFIG.c_micro_dma {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
 ] $axi_dma_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {6} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {3} \
 ] $axi_interconnect_1

  # Create instance: axi_read_cache_0, and set properties
  set block_name axi_read_cache
  set block_cell_name axi_read_cache_0
  if { [catch {set axi_read_cache_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_read_cache_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pcie
  create_hier_cell_pcie $hier_obj pcie

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_pins PCIE_REFCLK] [get_bd_intf_pins pcie/PCIE_REFCLK]
  connect_bd_intf_net -intf_net Conn [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins pcie/S_AXI]
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M04_AXI] [get_bd_intf_pins axi_interconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M05_AXI] [get_bd_intf_pins axi_interconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_1/S01_AXI]
  connect_bd_intf_net -intf_net S02_AXI_1 [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_1/S02_AXI]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins M_AXIS_MM2S] [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_read_cache_0/S_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axi_dma_0_M_AXI_SG] [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins pcie/SLOT_2_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins M00_AXI1] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_dma_0/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_interconnect_0/M03_AXI] [get_bd_intf_pins pcie/s_axi_intc]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins axi_interconnect_1/M01_AXI] [get_bd_intf_pins pcie/S_AXI_CTL]
  connect_bd_intf_net -intf_net axi_pcie_0_M_AXI [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins pcie/M_AXI]
  connect_bd_intf_net -intf_net axi_pcie_0_pcie_7x_mgt [get_bd_intf_pins pcie_7x_mgt_0] [get_bd_intf_pins pcie/pcie_7x_mgt_0]
  connect_bd_intf_net -intf_net axi_read_cache_0_M_AXI [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins axi_read_cache_0/M_AXI]
  connect_bd_intf_net -intf_net axis_interconnect_0_M04_AXIS [get_bd_intf_pins S_AXIS_S2MM] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]

  # Create port connections
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins pcie/In2]
  connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins pcie/intr_dma_mm2s]
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins pcie/intr_dma_s2mm]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins s_axi_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_0/m_axi_sg_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/M05_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_interconnect_1/S02_ACLK] [get_bd_pins axi_read_cache_0/ACLK] [get_bd_pins pcie/s_axi_aclk]
  connect_bd_net -net axi_pcie_0_axi_ctl_aclk_out [get_bd_pins axi_ctl_aclk_out] [get_bd_pins axi_interconnect_1/M01_ACLK] [get_bd_pins pcie/axi_ctl_aclk_out]
  connect_bd_net -net axi_pcie_0_mmcm_lock [get_bd_pins mmcm_lock] [get_bd_pins pcie/mmcm_lock]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins ARESETN] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/M05_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins axi_interconnect_1/S02_ARESETN] [get_bd_pins axi_read_cache_0/ARESETN] [get_bd_pins pcie/s_axi_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins M01_ARESETN] [get_bd_pins axi_interconnect_1/M01_ARESETN]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi_read_cache_0/INVALIDATE] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dino
proc create_hier_cell_dino { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_dino() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 I2C0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_REGISTER


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type clk clk_25mhz
  create_bd_pin -dir O conv_1
  create_bd_pin -dir O conv_2
  create_bd_pin -dir O -from 0 -to 0 dino_conv_oe
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir O -from 31 -to 0 out6
  create_bd_pin -dir I -type rst resetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O -type clk serial_clk_1
  create_bd_pin -dir O -type clk serial_clk_2
  create_bd_pin -dir O -from 7 -to 0 serial_clk_de
  create_bd_pin -dir I serial_data_1
  create_bd_pin -dir O serial_data_2
  create_bd_pin -dir O -from 7 -to 0 serial_data_de

  # Create instance: axi_clock_converter_0, and set properties
  set axi_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_0 ]

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0 ]

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.DEFAULT_TLAST {0} \
   CONFIG.M_TDATA_NUM_BYTES {2} \
   CONFIG.S_TDATA_NUM_BYTES {4} \
   CONFIG.TDATA_REMAP {tdata[15:0]} \
   CONFIG.TKEEP_REMAP {1'b0} \
   CONFIG.TLAST_REMAP {tlast[0]} \
 ] $axis_subset_converter_0

  # Create instance: config_timer_0, and set properties
  set block_name config_timer
  set block_cell_name config_timer_0
  if { [catch {set config_timer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $config_timer_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: dinoif_dac_0, and set properties
  set block_name dinoif_dac
  set block_cell_name dinoif_dac_0
  if { [catch {set dinoif_dac_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dinoif_dac_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: dinoif_fast_nologic_0, and set properties
  set block_name dinoif_fast_nologic
  set block_cell_name dinoif_fast_nologic_0
  if { [catch {set dinoif_fast_nologic_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dinoif_fast_nologic_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: registerif_0, and set properties
  set block_name registerif
  set block_cell_name registerif_0
  if { [catch {set registerif_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $registerif_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: scale_offset
  create_hier_cell_scale_offset $hier_obj scale_offset

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {158.5} \
   CONFIG.C_DATA_DEPTH {65536} \
   CONFIG.C_MON_TYPE {MIX} \
   CONFIG.C_NUM_MONITOR_SLOTS {3} \
   CONFIG.C_NUM_OF_PROBES {12} \
   CONFIG.C_SLOT {0} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1000} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0b00000010} \
   CONFIG.CONST_WIDTH {8} \
 ] $xlconstant_2

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xFF} \
   CONFIG.CONST_WIDTH {8} \
 ] $xlconstant_3

  # Create instance: xlconstant_7, and set properties
  set xlconstant_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_7 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xbad3b6ee} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_7

  # Create instance: xlconstant_8, and set properties
  set xlconstant_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_8 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x412ce5c9} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_8

  # Create instance: xlconstant_9, and set properties
  set xlconstant_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_9 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_9

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_A_1 [get_bd_intf_pins dinoif_fast_nologic_0/M00_AXIS] [get_bd_intf_pins scale_offset/S_AXIS_A]
  connect_bd_intf_net -intf_net [get_bd_intf_nets S_AXIS_A_1] [get_bd_intf_pins dinoif_fast_nologic_0/M00_AXIS] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net S_AXI_REGISTER_1 [get_bd_intf_pins S_AXI_REGISTER] [get_bd_intf_pins axi_clock_converter_0/S_AXI]
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins registerif_0/S_AXI]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_pins I2C0] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins dinoif_dac_0/S00_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_subset_converter_0_M_AXIS] [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins system_ila_0/SLOT_2_AXIS]
  connect_bd_intf_net -intf_net dma_pcie_M04_AXI [get_bd_intf_pins S_AXI_IIC] [get_bd_intf_pins axi_iic_0/S_AXI]
  connect_bd_intf_net -intf_net floating_point_1_M_AXIS_RESULT [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins scale_offset/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net [get_bd_intf_nets floating_point_1_M_AXIS_RESULT] [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins system_ila_0/SLOT_1_AXIS]

  # Create port connections
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins s_axi_aclk] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk]
  connect_bd_net -net clk_wiz_1_clk_100mhz [get_bd_pins aclk] [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins dinoif_dac_0/aclk] [get_bd_pins dinoif_fast_nologic_0/aclk] [get_bd_pins registerif_0/S_AXI_ACLK] [get_bd_pins scale_offset/aclk] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net clk_wiz_1_clk_25mhz [get_bd_pins clk_25mhz] [get_bd_pins config_timer_0/clk] [get_bd_pins dinoif_dac_0/clk_25mhz] [get_bd_pins dinoif_fast_nologic_0/clk_25mhz] [get_bd_pins system_ila_0/probe8]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins resetn] [get_bd_pins axi_clock_converter_0/m_axi_aresetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins config_timer_0/resetn] [get_bd_pins dinoif_dac_0/resetn] [get_bd_pins dinoif_fast_nologic_0/resetn] [get_bd_pins registerif_0/S_AXI_ARESETN] [get_bd_pins scale_offset/resetn] [get_bd_pins system_ila_0/resetn]
  connect_bd_net -net config_timer_0_thresh [get_bd_pins config_timer_0/thresh] [get_bd_pins dinoif_dac_0/external_trig] [get_bd_pins dinoif_fast_nologic_0/begin_conv] [get_bd_pins system_ila_0/probe4]
  connect_bd_net -net dinoif_dac_0_active [get_bd_pins dinoif_dac_0/active] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net dinoif_dac_0_load [get_bd_pins conv_2] [get_bd_pins dinoif_dac_0/load] [get_bd_pins system_ila_0/probe6]
  connect_bd_net -net dinoif_dac_0_serial_clk [get_bd_pins serial_clk_2] [get_bd_pins dinoif_dac_0/serial_clk] [get_bd_pins system_ila_0/probe7]
  connect_bd_net -net dinoif_dac_0_serial_data [get_bd_pins serial_data_2] [get_bd_pins dinoif_dac_0/serial_data] [get_bd_pins system_ila_0/probe5]
  connect_bd_net -net dinoif_fast_nologic_0_active [get_bd_pins dinoif_fast_nologic_0/active] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net dinoif_fast_nologic_0_conv [get_bd_pins conv_1] [get_bd_pins dinoif_fast_nologic_0/conv] [get_bd_pins system_ila_0/probe9]
  connect_bd_net -net dinoif_fast_nologic_0_serial_clk [get_bd_pins serial_clk_1] [get_bd_pins dinoif_fast_nologic_0/serial_clk] [get_bd_pins system_ila_0/probe10]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn]
  connect_bd_net -net registerif_0_out1 [get_bd_pins config_timer_0/cmp_val] [get_bd_pins registerif_0/out1] [get_bd_pins system_ila_0/probe0]
  connect_bd_net -net registerif_0_out4 [get_bd_pins registerif_0/out4] [get_bd_pins system_ila_0/probe3]
  connect_bd_net -net registerif_0_out5 [get_bd_pins registerif_0/out5] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net s_axis_b_tdata_1 [get_bd_pins registerif_0/out2] [get_bd_pins scale_offset/s_axis_b_tdata] [get_bd_pins system_ila_0/probe1]
  connect_bd_net -net s_axis_c_tdata_1 [get_bd_pins registerif_0/out3] [get_bd_pins scale_offset/s_axis_c_tdata] [get_bd_pins system_ila_0/probe2]
  connect_bd_net -net serial_data_1_1 [get_bd_pins serial_data_1] [get_bd_pins dinoif_fast_nologic_0/serial_data] [get_bd_pins system_ila_0/probe11]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins registerif_0/out6_default] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins registerif_0/out1_default] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins dino_conv_oe] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins serial_data_de] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins serial_clk_de] [get_bd_pins xlconstant_3/dout]
  connect_bd_net -net xlconstant_7_dout [get_bd_pins registerif_0/out2_default] [get_bd_pins xlconstant_7/dout]
  connect_bd_net -net xlconstant_8_dout [get_bd_pins registerif_0/out3_default] [get_bd_pins xlconstant_8/dout]
  connect_bd_net -net xlconstant_9_dout [get_bd_pins registerif_0/out4_default] [get_bd_pins registerif_0/out5_default] [get_bd_pins registerif_0/out7_default] [get_bd_pins registerif_0/out8_default] [get_bd_pins xlconstant_9/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins dinoif_dac_0/use_external_trig] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: crossbar
proc create_hier_cell_crossbar { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_crossbar() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M04_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M05_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S01_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S02_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S04_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S05_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type clk M04_AXIS_ACLK
  create_bd_pin -dir I -type rst M04_AXIS_ARESETN
  create_bd_pin -dir I -type clk S05_AXIS_ACLK
  create_bd_pin -dir I -type rst S05_AXIS_ARESETN
  create_bd_pin -dir I -type rst S_AXI_CTRL_ARESETN

  # Create instance: axis_clock_converter_0, and set properties
  set axis_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_0 ]

  # Create instance: axis_clock_converter_1, and set properties
  set axis_clock_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_1 ]

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.M00_FIFO_DEPTH {4096} \
   CONFIG.M00_FIFO_MODE {1} \
   CONFIG.M01_FIFO_DEPTH {4096} \
   CONFIG.M01_FIFO_MODE {1} \
   CONFIG.M02_FIFO_DEPTH {4096} \
   CONFIG.M02_FIFO_MODE {1} \
   CONFIG.M03_FIFO_DEPTH {4096} \
   CONFIG.M03_FIFO_MODE {1} \
   CONFIG.M04_FIFO_DEPTH {4096} \
   CONFIG.M04_FIFO_MODE {1} \
   CONFIG.M05_FIFO_DEPTH {32} \
   CONFIG.M06_FIFO_DEPTH {4096} \
   CONFIG.M06_FIFO_MODE {1} \
   CONFIG.NUM_MI {6} \
   CONFIG.NUM_SI {6} \
   CONFIG.ROUTING_MODE {1} \
   CONFIG.S00_FIFO_DEPTH {4096} \
   CONFIG.S00_FIFO_MODE {1} \
   CONFIG.S00_HAS_REGSLICE {0} \
   CONFIG.S01_FIFO_DEPTH {4096} \
   CONFIG.S01_FIFO_MODE {1} \
   CONFIG.S02_FIFO_DEPTH {4096} \
   CONFIG.S02_FIFO_MODE {1} \
   CONFIG.S03_FIFO_DEPTH {4096} \
   CONFIG.S03_FIFO_MODE {1} \
   CONFIG.S04_FIFO_DEPTH {32} \
   CONFIG.S04_FIFO_MODE {0} \
   CONFIG.S05_FIFO_DEPTH {32} \
   CONFIG.S06_FIFO_DEPTH {4096} \
   CONFIG.S06_FIFO_MODE {1} \
 ] $axis_interconnect_0

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {35} \
   CONFIG.C_DATA_DEPTH {4096} \
   CONFIG.C_MON_TYPE {MIX} \
   CONFIG.C_NUM_MONITOR_SLOTS {8} \
   CONFIG.C_NUM_OF_PROBES {1} \
   CONFIG.C_SLOT {0} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_10_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_11_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_12_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_4_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_5_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_6_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_7_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_8_INTF_TYPE {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.C_SLOT_9_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_0

  # Create instance: system_ila_1, and set properties
  set system_ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_1 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {9} \
   CONFIG.C_DATA_DEPTH {4096} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_NUM_MONITOR_SLOTS {4} \
   CONFIG.C_NUM_OF_PROBES {0} \
   CONFIG.C_SLOT {3} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
   CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins axis_interconnect_0/M05_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn1] [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins system_ila_1/SLOT_2_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins axis_interconnect_0/S05_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn2] [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins system_ila_1/SLOT_3_AXIS]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets S00_AXIS_1] [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins system_ila_0/SLOT_4_AXIS]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets S02_AXIS_1] [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins system_ila_0/SLOT_6_AXIS]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets S03_AXIS_1] [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins system_ila_0/SLOT_7_AXIS]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins axis_clock_converter_1/S_AXIS]
  connect_bd_intf_net -intf_net axi_crossbar_0_M00_AXI [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axis_interconnect_0/S_AXI_CTRL]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins axis_clock_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_1_M_AXIS [get_bd_intf_pins axis_clock_converter_1/M_AXIS] [get_bd_intf_pins axis_interconnect_0/S04_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_clock_converter_1_M_AXIS] [get_bd_intf_pins axis_clock_converter_1/M_AXIS] [get_bd_intf_pins system_ila_1/SLOT_1_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_interconnect_0_M00_AXIS] [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_interconnect_0_M01_AXIS1] [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins system_ila_0/SLOT_1_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_interconnect_0_M02_AXIS] [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins system_ila_0/SLOT_2_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_interconnect_0_M03_AXIS] [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins system_ila_0/SLOT_3_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M04_AXIS [get_bd_intf_pins axis_clock_converter_0/S_AXIS] [get_bd_intf_pins axis_interconnect_0/M04_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_interconnect_0_M04_AXIS] [get_bd_intf_pins axis_interconnect_0/M04_AXIS] [get_bd_intf_pins system_ila_1/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net rtds_seqnum_fix_inco_0_m_axis [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net [get_bd_intf_nets rtds_seqnum_fix_inco_0_m_axis] [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins system_ila_0/SLOT_5_AXIS]

  # Create port connections
  connect_bd_net -net S05_AXIS_ACLK_1 [get_bd_pins S05_AXIS_ACLK] [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_clock_converter_1/m_axis_aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M04_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M05_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S04_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S05_AXIS_ACLK] [get_bd_pins system_ila_1/clk]
  connect_bd_net -net S05_AXIS_ARESETN_1 [get_bd_pins S05_AXIS_ARESETN] [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_clock_converter_1/m_axis_aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M04_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M05_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S04_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S05_AXIS_ARESETN] [get_bd_pins system_ila_1/resetn]
  connect_bd_net -net aurora_8b10b_0_user_clk_out [get_bd_pins ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins M04_AXIS_ACLK] [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_clock_converter_1/s_axis_aclk] [get_bd_pins axis_interconnect_0/S_AXI_CTRL_ACLK]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins M04_AXIS_ARESETN] [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_clock_converter_1/s_axis_aresetn] [get_bd_pins axis_interconnect_0/S_AXI_CTRL_ARESETN]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins S_AXI_CTRL_ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN] [get_bd_pins system_ila_0/probe0]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: aurora
proc create_hier_cell_aurora { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_aurora() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GT_DIFF_REFCLK1_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_M_AXI_RX

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_M_AXI_RX1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_M_AXI_RX2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_M_AXI_RX3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_S_AXI_TX

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_S_AXI_TX1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_S_AXI_TX2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 USER_DATA_S_AXI_TX3


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 aurora_reset
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir O -type clk user_clk

  # Create instance: aurora_8b10b_ch0, and set properties
  set aurora_8b10b_ch0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.1 aurora_8b10b_ch0 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y0} \
   CONFIG.C_DRP_IF {false} \
   CONFIG.C_GT_CLOCK_1 {GTXQ0} \
   CONFIG.C_GT_LOC_1 {1} \
   CONFIG.C_GT_LOC_15 {X} \
   CONFIG.C_GT_LOC_28 {X} \
   CONFIG.C_LANE_WIDTH {4} \
   CONFIG.C_LINE_RATE {2} \
   CONFIG.C_REFCLK_FREQUENCY {250.000} \
   CONFIG.C_REFCLK_SOURCE {none} \
   CONFIG.C_START_LANE {X0Y0} \
   CONFIG.C_START_QUAD {X0Y0} \
   CONFIG.C_USE_CRC {true} \
   CONFIG.SINGLEEND_GTREFCLK {true} \
   CONFIG.SINGLEEND_INITCLK {true} \
   CONFIG.SupportLevel {1} \
 ] $aurora_8b10b_ch0

  # Create instance: aurora_8b10b_ch1, and set properties
  set aurora_8b10b_ch1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.1 aurora_8b10b_ch1 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y0} \
   CONFIG.C_DRP_IF {false} \
   CONFIG.C_GT_CLOCK_1 {GTXQ0} \
   CONFIG.C_GT_LOC_1 {1} \
   CONFIG.C_GT_LOC_11 {X} \
   CONFIG.C_GT_LOC_27 {X} \
   CONFIG.C_LANE_WIDTH {4} \
   CONFIG.C_LINE_RATE {2} \
   CONFIG.C_REFCLK_FREQUENCY {250.000} \
   CONFIG.C_REFCLK_SOURCE {none} \
   CONFIG.C_START_LANE {X0Y0} \
   CONFIG.C_START_QUAD {X0Y0} \
   CONFIG.C_USE_CRC {false} \
   CONFIG.SINGLEEND_GTREFCLK {false} \
   CONFIG.SINGLEEND_INITCLK {false} \
   CONFIG.SupportLevel {0} \
 ] $aurora_8b10b_ch1

  # Create instance: aurora_8b10b_ch2, and set properties
  set aurora_8b10b_ch2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.1 aurora_8b10b_ch2 ]
  set_property -dict [ list \
   CONFIG.C_DRP_IF {false} \
   CONFIG.C_GT_CLOCK_1 {GTXQ6} \
   CONFIG.C_GT_LOC_1 {X} \
   CONFIG.C_GT_LOC_26 {1} \
   CONFIG.C_LANE_WIDTH {4} \
   CONFIG.C_LINE_RATE {2} \
   CONFIG.C_REFCLK_FREQUENCY {250.000} \
   CONFIG.C_USE_CRC {false} \
 ] $aurora_8b10b_ch2

  # Create instance: aurora_8b10b_ch3, and set properties
  set aurora_8b10b_ch3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.1 aurora_8b10b_ch3 ]
  set_property -dict [ list \
   CONFIG.C_DRP_IF {false} \
   CONFIG.C_GT_CLOCK_1 {GTXQ6} \
   CONFIG.C_GT_LOC_1 {X} \
   CONFIG.C_GT_LOC_25 {1} \
   CONFIG.C_LANE_WIDTH {4} \
   CONFIG.C_LINE_RATE {2} \
   CONFIG.C_REFCLK_FREQUENCY {250.000} \
   CONFIG.C_USE_CRC {false} \
 ] $aurora_8b10b_ch3

  # Create instance: aurora_demo_0, and set properties
  set block_name aurora_demo
  set block_cell_name aurora_demo_0
  if { [catch {set aurora_demo_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $aurora_demo_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] [get_bd_pins /aurora/aurora_demo_0/reset]

  # Create instance: channel_up, and set properties
  set channel_up [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 channel_up ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $channel_up

  # Create instance: frame_err, and set properties
  set frame_err [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 frame_err ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $frame_err

  # Create instance: hard_err, and set properties
  set hard_err [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 hard_err ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $hard_err

  # Create instance: lane_up, and set properties
  set lane_up [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 lane_up ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $lane_up

  # Create instance: soft_err, and set properties
  set soft_err [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 soft_err ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $soft_err

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {1} \
   CONFIG.C_DATA_DEPTH {4096} \
   CONFIG.C_MON_TYPE {NATIVE} \
   CONFIG.C_NUM_OF_PROBES {7} \
 ] $system_ila_0

  # Create instance: tx_lock, and set properties
  set tx_lock [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 tx_lock ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $tx_lock

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_1

  # Create interface connections
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_pins GT_DIFF_REFCLK1_0] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_0_1 [get_bd_intf_pins GT_SERIAL_RX_0] [get_bd_intf_pins aurora_8b10b_ch0/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_1_1 [get_bd_intf_pins GT_SERIAL_RX_1] [get_bd_intf_pins aurora_8b10b_ch1/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_2_1 [get_bd_intf_pins GT_SERIAL_RX_2] [get_bd_intf_pins aurora_8b10b_ch2/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_3_1 [get_bd_intf_pins GT_SERIAL_RX_3] [get_bd_intf_pins aurora_8b10b_ch3/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins USER_DATA_M_AXI_RX] [get_bd_intf_pins aurora_8b10b_ch0/USER_DATA_M_AXI_RX]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins USER_DATA_M_AXI_RX2] [get_bd_intf_pins aurora_8b10b_ch2/USER_DATA_M_AXI_RX]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins USER_DATA_M_AXI_RX3] [get_bd_intf_pins aurora_8b10b_ch3/USER_DATA_M_AXI_RX]
  connect_bd_intf_net -intf_net aurora_8b10b_0_GT_SERIAL_TX [get_bd_intf_pins GT_SERIAL_TX_0] [get_bd_intf_pins aurora_8b10b_ch0/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_8b10b_1_GT_SERIAL_TX [get_bd_intf_pins GT_SERIAL_TX_1] [get_bd_intf_pins aurora_8b10b_ch1/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_8b10b_2_GT_SERIAL_TX [get_bd_intf_pins GT_SERIAL_TX_3] [get_bd_intf_pins aurora_8b10b_ch3/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_8b10b_3_GT_SERIAL_TX [get_bd_intf_pins GT_SERIAL_TX_2] [get_bd_intf_pins aurora_8b10b_ch2/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins USER_DATA_S_AXI_TX] [get_bd_intf_pins aurora_8b10b_ch0/USER_DATA_S_AXI_TX]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS1 [get_bd_intf_pins USER_DATA_S_AXI_TX1] [get_bd_intf_pins aurora_8b10b_ch1/USER_DATA_S_AXI_TX]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins USER_DATA_S_AXI_TX2] [get_bd_intf_pins aurora_8b10b_ch2/USER_DATA_S_AXI_TX]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins USER_DATA_S_AXI_TX3] [get_bd_intf_pins aurora_8b10b_ch3/USER_DATA_S_AXI_TX]
  connect_bd_intf_net -intf_net rtds_seqnum_fix_inco_0_m_axis [get_bd_intf_pins USER_DATA_M_AXI_RX1] [get_bd_intf_pins aurora_8b10b_ch1/USER_DATA_M_AXI_RX]

  # Create port connections
  connect_bd_net -net Net3 [get_bd_pins clk] [get_bd_pins aurora_8b10b_ch0/drpclk_in] [get_bd_pins aurora_8b10b_ch0/init_clk_in] [get_bd_pins aurora_8b10b_ch1/drpclk_in] [get_bd_pins aurora_8b10b_ch1/init_clk_in] [get_bd_pins aurora_8b10b_ch2/drpclk_in] [get_bd_pins aurora_8b10b_ch2/init_clk_in] [get_bd_pins aurora_8b10b_ch3/drpclk_in] [get_bd_pins aurora_8b10b_ch3/init_clk_in] [get_bd_pins aurora_demo_0/clk]
  connect_bd_net -net aurora_8b10b_0_gt_reset_out [get_bd_pins aurora_8b10b_ch0/gt_reset_out] [get_bd_pins aurora_8b10b_ch1/gt_reset] [get_bd_pins aurora_8b10b_ch2/gt_reset] [get_bd_pins aurora_8b10b_ch3/gt_reset]
  connect_bd_net -net aurora_8b10b_0_pll_not_locked_out [get_bd_pins aurora_8b10b_ch0/pll_not_locked_out] [get_bd_pins aurora_8b10b_ch1/pll_not_locked] [get_bd_pins aurora_8b10b_ch2/pll_not_locked] [get_bd_pins aurora_8b10b_ch3/pll_not_locked]
  connect_bd_net -net aurora_8b10b_0_sync_clk_out [get_bd_pins aurora_8b10b_ch0/sync_clk_out] [get_bd_pins aurora_8b10b_ch1/sync_clk] [get_bd_pins aurora_8b10b_ch2/sync_clk] [get_bd_pins aurora_8b10b_ch3/sync_clk]
  connect_bd_net -net aurora_8b10b_0_sys_reset_out [get_bd_pins aurora_8b10b_ch0/sys_reset_out] [get_bd_pins aurora_8b10b_ch1/reset] [get_bd_pins aurora_8b10b_ch2/reset] [get_bd_pins aurora_8b10b_ch3/reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net aurora_8b10b_0_user_clk_out [get_bd_pins user_clk] [get_bd_pins aurora_8b10b_ch0/user_clk_out] [get_bd_pins aurora_8b10b_ch1/user_clk] [get_bd_pins aurora_8b10b_ch2/user_clk] [get_bd_pins aurora_8b10b_ch3/user_clk] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net aurora_8b10b_ch0_channel_up [get_bd_pins aurora_8b10b_ch0/channel_up] [get_bd_pins channel_up/In0]
  connect_bd_net -net aurora_8b10b_ch0_frame_err [get_bd_pins aurora_8b10b_ch0/frame_err] [get_bd_pins frame_err/In0]
  connect_bd_net -net aurora_8b10b_ch0_gt_qpllclk_quad1_out [get_bd_pins aurora_8b10b_ch0/gt_qpllclk_quad1_out] [get_bd_pins aurora_8b10b_ch1/gt_qpllclk_quad1_in] [get_bd_pins aurora_8b10b_ch2/gt_qpllclk_quad7_in] [get_bd_pins aurora_8b10b_ch3/gt_qpllclk_quad7_in]
  connect_bd_net -net aurora_8b10b_ch0_gt_qpllrefclk_quad1_out [get_bd_pins aurora_8b10b_ch0/gt_qpllrefclk_quad1_out] [get_bd_pins aurora_8b10b_ch1/gt_qpllrefclk_quad1_in] [get_bd_pins aurora_8b10b_ch2/gt_qpllrefclk_quad7_in] [get_bd_pins aurora_8b10b_ch3/gt_qpllrefclk_quad7_in]
  connect_bd_net -net aurora_8b10b_ch0_hard_err [get_bd_pins aurora_8b10b_ch0/hard_err] [get_bd_pins hard_err/In0]
  connect_bd_net -net aurora_8b10b_ch0_lane_up [get_bd_pins aurora_8b10b_ch0/lane_up] [get_bd_pins lane_up/In0]
  connect_bd_net -net aurora_8b10b_ch0_soft_err [get_bd_pins aurora_8b10b_ch0/soft_err] [get_bd_pins soft_err/In0]
  connect_bd_net -net aurora_8b10b_ch0_tx_lock [get_bd_pins aurora_8b10b_ch0/tx_lock] [get_bd_pins tx_lock/In0]
  connect_bd_net -net aurora_8b10b_ch1_channel_up [get_bd_pins aurora_8b10b_ch1/channel_up] [get_bd_pins channel_up/In1]
  connect_bd_net -net aurora_8b10b_ch1_frame_err [get_bd_pins aurora_8b10b_ch1/frame_err] [get_bd_pins frame_err/In1]
  connect_bd_net -net aurora_8b10b_ch1_hard_err [get_bd_pins aurora_8b10b_ch1/hard_err] [get_bd_pins hard_err/In1]
  connect_bd_net -net aurora_8b10b_ch1_lane_up [get_bd_pins aurora_8b10b_ch1/lane_up] [get_bd_pins lane_up/In1]
  connect_bd_net -net aurora_8b10b_ch1_soft_err [get_bd_pins aurora_8b10b_ch1/soft_err] [get_bd_pins soft_err/In1]
  connect_bd_net -net aurora_8b10b_ch1_tx_lock [get_bd_pins aurora_8b10b_ch1/tx_lock] [get_bd_pins tx_lock/In1]
  connect_bd_net -net aurora_8b10b_ch2_channel_up [get_bd_pins aurora_8b10b_ch2/channel_up] [get_bd_pins channel_up/In2]
  connect_bd_net -net aurora_8b10b_ch2_frame_err [get_bd_pins aurora_8b10b_ch2/frame_err] [get_bd_pins frame_err/In2]
  connect_bd_net -net aurora_8b10b_ch2_hard_err [get_bd_pins aurora_8b10b_ch2/hard_err] [get_bd_pins hard_err/In2]
  connect_bd_net -net aurora_8b10b_ch2_lane_up [get_bd_pins aurora_8b10b_ch2/lane_up] [get_bd_pins lane_up/In2]
  connect_bd_net -net aurora_8b10b_ch2_soft_err [get_bd_pins aurora_8b10b_ch2/soft_err] [get_bd_pins soft_err/In2]
  connect_bd_net -net aurora_8b10b_ch2_tx_lock [get_bd_pins aurora_8b10b_ch2/tx_lock] [get_bd_pins tx_lock/In2]
  connect_bd_net -net aurora_8b10b_ch3_channel_up [get_bd_pins aurora_8b10b_ch3/channel_up] [get_bd_pins channel_up/In3]
  connect_bd_net -net aurora_8b10b_ch3_frame_err [get_bd_pins aurora_8b10b_ch3/frame_err] [get_bd_pins frame_err/In3]
  connect_bd_net -net aurora_8b10b_ch3_hard_err [get_bd_pins aurora_8b10b_ch3/hard_err] [get_bd_pins hard_err/In3]
  connect_bd_net -net aurora_8b10b_ch3_lane_up [get_bd_pins aurora_8b10b_ch3/lane_up] [get_bd_pins lane_up/In3]
  connect_bd_net -net aurora_8b10b_ch3_soft_err [get_bd_pins aurora_8b10b_ch3/soft_err] [get_bd_pins soft_err/In3]
  connect_bd_net -net aurora_8b10b_ch3_tx_lock [get_bd_pins aurora_8b10b_ch3/tx_lock] [get_bd_pins tx_lock/In3]
  connect_bd_net -net aurora_demo_0_reset [get_bd_pins aurora_8b10b_ch0/gt_reset] [get_bd_pins aurora_8b10b_ch0/reset] [get_bd_pins aurora_demo_0/reset]
  connect_bd_net -net channel_up_dout [get_bd_pins channel_up/dout] [get_bd_pins system_ila_0/probe5]
  connect_bd_net -net frame_err_dout [get_bd_pins frame_err/dout] [get_bd_pins system_ila_0/probe4]
  connect_bd_net -net hard_err_dout [get_bd_pins hard_err/dout] [get_bd_pins system_ila_0/probe3]
  connect_bd_net -net lane_up_dout [get_bd_pins lane_up/dout] [get_bd_pins system_ila_0/probe2]
  connect_bd_net -net soft_err_dout [get_bd_pins soft_err/dout] [get_bd_pins system_ila_0/probe1]
  connect_bd_net -net tx_lock_dout [get_bd_pins system_ila_0/probe0] [get_bd_pins tx_lock/dout]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins aurora_8b10b_ch0/gt_refclk1] [get_bd_pins aurora_8b10b_ch1/gt_refclk1] [get_bd_pins aurora_8b10b_ch2/gt_refclk1] [get_bd_pins aurora_8b10b_ch3/gt_refclk1] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins aurora_reset] [get_bd_pins system_ila_0/probe6] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins aurora_8b10b_ch0/loopback] [get_bd_pins aurora_8b10b_ch1/loopback] [get_bd_pins aurora_8b10b_ch2/loopback] [get_bd_pins aurora_8b10b_ch3/loopback] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins aurora_8b10b_ch0/power_down] [get_bd_pins aurora_8b10b_ch1/power_down] [get_bd_pins aurora_8b10b_ch2/power_down] [get_bd_pins aurora_8b10b_ch3/power_down] [get_bd_pins xlconstant_1/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set GT_DIFF_REFCLK1_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GT_DIFF_REFCLK1_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
   ] $GT_DIFF_REFCLK1_0

  set GT_SERIAL_RX_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_0 ]

  set GT_SERIAL_RX_1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_1 ]

  set GT_SERIAL_RX_2 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_2 ]

  set GT_SERIAL_RX_3 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX_3 ]

  set GT_SERIAL_TX_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_0 ]

  set GT_SERIAL_TX_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_1 ]

  set GT_SERIAL_TX_2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_2 ]

  set GT_SERIAL_TX_3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX_3 ]

  set I2C0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 I2C0 ]

  set PCIE_REFCLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 PCIE_REFCLK ]

  set led_pins [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 led_pins ]

  set pcie_7x_mgt_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt_0 ]

  set sys_diff_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_diff_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys_diff_clock


  # Create ports
  set CLK_SWITCHES [ create_bd_port -dir O -from 3 -to 0 CLK_SWITCHES ]
  set GT_SERIAL_DISABLE_TX_0 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_DISABLE_TX_0 ]
  set GT_SERIAL_DISABLE_TX_1 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_DISABLE_TX_1 ]
  set GT_SERIAL_DISABLE_TX_2 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_DISABLE_TX_2 ]
  set GT_SERIAL_DISABLE_TX_3 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_DISABLE_TX_3 ]
  set GT_SERIAL_RS_0 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_RS_0 ]
  set GT_SERIAL_RS_1 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_RS_1 ]
  set GT_SERIAL_RS_2 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_RS_2 ]
  set GT_SERIAL_RS_3 [ create_bd_port -dir O -from 0 -to 0 GT_SERIAL_RS_3 ]
  set aux_reset_in_0 [ create_bd_port -dir I -type rst aux_reset_in_0 ]
  set conv_1 [ create_bd_port -dir O conv_1 ]
  set conv_2 [ create_bd_port -dir O conv_2 ]
  set conv_oe [ create_bd_port -dir O -from 0 -to 0 conv_oe ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset
  set serial_clk_1 [ create_bd_port -dir O -type clk serial_clk_1 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {25000000} \
 ] $serial_clk_1
  set serial_clk_2 [ create_bd_port -dir O -type clk serial_clk_2 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {25000000} \
 ] $serial_clk_2
  set serial_clk_de [ create_bd_port -dir O -from 7 -to 0 serial_clk_de ]
  set serial_data_1 [ create_bd_port -dir I serial_data_1 ]
  set serial_data_2 [ create_bd_port -dir O serial_data_2 ]
  set serial_data_de [ create_bd_port -dir O -from 7 -to 0 serial_data_de ]

  # Create instance: aurora
  create_hier_cell_aurora [current_bd_instance .] aurora

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {8} \
   CONFIG.GPIO_BOARD_INTERFACE {led_8bits} \
 ] $axi_gpio_0

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {50.0} \
   CONFIG.CLKOUT1_JITTER {112.316} \
   CONFIG.CLKOUT1_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT2_JITTER {148.629} \
   CONFIG.CLKOUT2_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {25.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sys_diff_clock} \
   CONFIG.CLK_OUT1_PORT {clk_100mhz} \
   CONFIG.CLK_OUT2_PORT {clk_25mhz} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {5.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {40} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_IN_FREQ {200.000} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $clk_wiz_1

  # Create instance: crossbar
  create_hier_cell_crossbar [current_bd_instance .] crossbar

  # Create instance: dino
  create_hier_cell_dino [current_bd_instance .] dino

  # Create instance: dma_pcie
  create_hier_cell_dma_pcie [current_bd_instance .] dma_pcie

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
 ] $proc_sys_reset_0

  # Create instance: xlconstant_4, and set properties
  set xlconstant_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_4 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_4

  # Create instance: xlconstant_5, and set properties
  set xlconstant_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_5 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0b0101} \
   CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_5

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports PCIE_REFCLK] [get_bd_intf_pins dma_pcie/PCIE_REFCLK]
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_ports GT_DIFF_REFCLK1_0] [get_bd_intf_pins aurora/GT_DIFF_REFCLK1_0]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_0_1 [get_bd_intf_ports GT_SERIAL_RX_0] [get_bd_intf_pins aurora/GT_SERIAL_RX_0]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_1_1 [get_bd_intf_ports GT_SERIAL_RX_1] [get_bd_intf_pins aurora/GT_SERIAL_RX_1]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_2_1 [get_bd_intf_ports GT_SERIAL_RX_2] [get_bd_intf_pins aurora/GT_SERIAL_RX_2]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_3_1 [get_bd_intf_ports GT_SERIAL_RX_3] [get_bd_intf_pins aurora/GT_SERIAL_RX_3]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins aurora/USER_DATA_M_AXI_RX] [get_bd_intf_pins crossbar/S00_AXIS]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins aurora/USER_DATA_M_AXI_RX2] [get_bd_intf_pins crossbar/S02_AXIS]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins aurora/USER_DATA_M_AXI_RX3] [get_bd_intf_pins crossbar/S03_AXIS]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins crossbar/S04_AXIS] [get_bd_intf_pins dma_pcie/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net S_AXI_0_1 [get_bd_intf_pins dino/S_AXI_REGISTER] [get_bd_intf_pins dma_pcie/M05_AXI]
  connect_bd_intf_net -intf_net aurora_8b10b_0_GT_SERIAL_TX [get_bd_intf_ports GT_SERIAL_TX_0] [get_bd_intf_pins aurora/GT_SERIAL_TX_0]
  connect_bd_intf_net -intf_net aurora_8b10b_1_GT_SERIAL_TX [get_bd_intf_ports GT_SERIAL_TX_1] [get_bd_intf_pins aurora/GT_SERIAL_TX_1]
  connect_bd_intf_net -intf_net aurora_8b10b_2_GT_SERIAL_TX [get_bd_intf_ports GT_SERIAL_TX_3] [get_bd_intf_pins aurora/GT_SERIAL_TX_3]
  connect_bd_intf_net -intf_net aurora_8b10b_3_GT_SERIAL_TX [get_bd_intf_ports GT_SERIAL_TX_2] [get_bd_intf_pins aurora/GT_SERIAL_TX_2]
  connect_bd_intf_net -intf_net axi_crossbar_0_M00_AXI [get_bd_intf_pins crossbar/S_AXI_CTRL] [get_bd_intf_pins dma_pcie/M00_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports led_pins] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins dma_pcie/M00_AXI1]
  connect_bd_intf_net -intf_net axi_pcie_0_pcie_7x_mgt [get_bd_intf_ports pcie_7x_mgt_0] [get_bd_intf_pins dma_pcie/pcie_7x_mgt_0]
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins aurora/USER_DATA_S_AXI_TX] [get_bd_intf_pins crossbar/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS1 [get_bd_intf_pins aurora/USER_DATA_S_AXI_TX1] [get_bd_intf_pins crossbar/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins aurora/USER_DATA_S_AXI_TX2] [get_bd_intf_pins crossbar/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins aurora/USER_DATA_S_AXI_TX3] [get_bd_intf_pins crossbar/M03_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M04_AXIS [get_bd_intf_pins crossbar/M04_AXIS] [get_bd_intf_pins dma_pcie/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net crossbar_M05_AXIS [get_bd_intf_pins crossbar/M05_AXIS] [get_bd_intf_pins dino/S00_AXIS]
  connect_bd_intf_net -intf_net dino_I2C0 [get_bd_intf_ports I2C0] [get_bd_intf_pins dino/I2C0]
  connect_bd_intf_net -intf_net dinoif_fast_0_M00_AXIS [get_bd_intf_pins crossbar/S05_AXIS] [get_bd_intf_pins dino/M00_AXIS]
  connect_bd_intf_net -intf_net dma_pcie_M04_AXI [get_bd_intf_pins dino/S_AXI_IIC] [get_bd_intf_pins dma_pcie/M04_AXI]
  connect_bd_intf_net -intf_net rtds_seqnum_fix_inco_0_m_axis [get_bd_intf_pins aurora/USER_DATA_M_AXI_RX1] [get_bd_intf_pins crossbar/S01_AXIS]
  connect_bd_intf_net -intf_net sys_diff_clock_1 [get_bd_intf_ports sys_diff_clock] [get_bd_intf_pins clk_wiz_1/CLK_IN1_D]

  # Create port connections
  connect_bd_net -net aurora_8b10b_0_user_clk_out [get_bd_pins aurora/user_clk] [get_bd_pins crossbar/ACLK]
  connect_bd_net -net aux_reset_in_0_1 [get_bd_ports aux_reset_in_0] [get_bd_pins proc_sys_reset_0/aux_reset_in]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins dino/iic2intc_irpt] [get_bd_pins dma_pcie/In2]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins crossbar/M04_AXIS_ACLK] [get_bd_pins dino/s_axi_aclk] [get_bd_pins dma_pcie/s_axi_aclk]
  connect_bd_net -net axi_pcie_0_axi_ctl_aclk_out [get_bd_pins dma_pcie/axi_ctl_aclk_out] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net axi_pcie_0_mmcm_lock [get_bd_pins dma_pcie/mmcm_lock] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net clk_wiz_1_clk_100mhz [get_bd_pins aurora/clk] [get_bd_pins clk_wiz_1/clk_100mhz] [get_bd_pins crossbar/S05_AXIS_ACLK] [get_bd_pins dino/aclk]
  connect_bd_net -net clk_wiz_1_clk_25mhz [get_bd_pins clk_wiz_1/clk_25mhz] [get_bd_pins dino/clk_25mhz]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins crossbar/S05_AXIS_ARESETN] [get_bd_pins dino/resetn]
  connect_bd_net -net dino_adc_serial_data_1 [get_bd_ports serial_data_1] [get_bd_pins dino/serial_data_1]
  connect_bd_net -net dinoif_dac_0_load [get_bd_ports conv_2] [get_bd_pins dino/conv_2]
  connect_bd_net -net dinoif_dac_0_serial_clk [get_bd_ports serial_clk_2] [get_bd_pins dino/serial_clk_2]
  connect_bd_net -net dinoif_dac_0_serial_data [get_bd_ports serial_data_2] [get_bd_pins dino/serial_data_2]
  connect_bd_net -net dinoif_fast_0_conv [get_bd_ports conv_1] [get_bd_pins dino/conv_1]
  connect_bd_net -net dinoif_fast_0_serial_clk [get_bd_ports serial_clk_1] [get_bd_pins dino/serial_clk_1]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins crossbar/M04_AXIS_ARESETN] [get_bd_pins dino/s_axi_aresetn] [get_bd_pins dma_pcie/ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins dma_pcie/M01_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clk_wiz_1/reset] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins aurora/aurora_reset] [get_bd_pins crossbar/S_AXI_CTRL_ARESETN]
  connect_bd_net -net xlconstant_1_dout [get_bd_ports conv_oe] [get_bd_pins dino/dino_conv_oe]
  connect_bd_net -net xlconstant_2_dout [get_bd_ports serial_data_de] [get_bd_pins dino/serial_data_de]
  connect_bd_net -net xlconstant_3_dout [get_bd_ports serial_clk_de] [get_bd_pins dino/serial_clk_de]
  connect_bd_net -net xlconstant_4_dout [get_bd_ports GT_SERIAL_DISABLE_TX_0] [get_bd_ports GT_SERIAL_DISABLE_TX_1] [get_bd_ports GT_SERIAL_DISABLE_TX_2] [get_bd_ports GT_SERIAL_DISABLE_TX_3] [get_bd_ports GT_SERIAL_RS_0] [get_bd_ports GT_SERIAL_RS_1] [get_bd_ports GT_SERIAL_RS_2] [get_bd_ports GT_SERIAL_RS_3] [get_bd_pins xlconstant_4/dout]
  connect_bd_net -net xlconstant_5_dout [get_bd_ports CLK_SWITCHES] [get_bd_pins xlconstant_5/dout]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces dma_pcie/axi_dma_0/Data_MM2S] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI/BAR0] -force
  assign_bd_address -offset 0x00000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces dma_pcie/axi_dma_0/Data_S2MM] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI/BAR0] -force
  assign_bd_address -offset 0x00000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces dma_pcie/axi_read_cache_0/M_AXI] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI/BAR0] -force
  assign_bd_address -offset 0x00003000 -range 0x00000400 -target_address_space [get_bd_addr_spaces dma_pcie/pcie/axi_pcie_0/M_AXI] [get_bd_addr_segs dma_pcie/axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00000080 -target_address_space [get_bd_addr_spaces dma_pcie/pcie/axi_pcie_0/M_AXI] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00004000 -range 0x00000400 -target_address_space [get_bd_addr_spaces dma_pcie/pcie/axi_pcie_0/M_AXI] [get_bd_addr_segs dino/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00002000 -range 0x00000400 -target_address_space [get_bd_addr_spaces dma_pcie/pcie/axi_pcie_0/M_AXI] [get_bd_addr_segs dma_pcie/pcie/pcie_interrupts/axi_pcie_intc_0/s_axi/reg0] -force
  assign_bd_address -offset 0x00005000 -range 0x00000400 -target_address_space [get_bd_addr_spaces dma_pcie/pcie/axi_pcie_0/M_AXI] [get_bd_addr_segs dino/registerif_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00001000 -range 0x00000400 -target_address_space [get_bd_addr_spaces dma_pcie/pcie/axi_pcie_0/M_AXI] [get_bd_addr_segs crossbar/axis_interconnect_0/xbar/S_AXI_CTRL/Reg] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces dma_pcie/axi_dma_0/Data_MM2S] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI_CTL/CTL0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces dma_pcie/axi_dma_0/Data_S2MM] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI_CTL/CTL0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces dma_pcie/axi_dma_0/Data_SG] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI_CTL/CTL0]
  exclude_bd_addr_seg -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces dma_pcie/axi_dma_0/Data_SG] [get_bd_addr_segs dma_pcie/axi_read_cache_0/S_AXI/reg0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces dma_pcie/axi_read_cache_0/M_AXI] [get_bd_addr_segs dma_pcie/pcie/axi_pcie_0/S_AXI_CTL/CTL0]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


