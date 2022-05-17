Connect the VC707 via PCIe to a host. The bitstream connect the LEDs on the VC707 to the PCIe interface.
An ILA can be used to inspect the AXI traffic between PCIe bridge and AXI_GPIO IP.


(Re)attach device:
```
echo "1" > /sys/bus/pci/devices/<PCI ID>/remove
echo "1" > /sys/bus/pci/rescan
echo "1" > /sys/bus/pci/devices/<PCI ID>/enable
```

After attaching `lspci` should show the device:
```
88:00.0 Memory controller: Xilinx Corporation Device 7028 (rev ff)
```

`dmesg` should show something like
```
[5172931.880760] pcieport 0000:87:08.0: Slot(72): Card present
[5172931.880763] pcieport 0000:87:08.0: Slot(72): Link Up
[5172931.880766] pcieport 0000:87:08.0: Slot(72): Latch open
[5175194.480372] pci 0000:88:00.0: Removing from iommu group 100
[5175199.161489] pci 0000:88:00.0: [10ee:7028] type 00 class 0x058000
[5175199.161525] pci 0000:88:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[5175199.161598] pci 0000:88:00.0: Max Payload Size set to 256 (was 128, max 256)
[5175199.161604] pci 0000:88:00.0: enabling Extended Tags
[5175199.162258] pci 0000:88:00.0: Adding to iommu group 100
[5175199.162424] pci 0000:88:00.0: BAR 0: assigned [mem 0xd3a00000-0xd3afffff]
[5175204.479741] pci 0000:88:00.0: enabling device (0000 -> 0002)
[5176827.180720] pcieport 0000:87:08.0: Slot(72): Card present
[5176827.180725] pcieport 0000:87:08.0: Slot(72): Latch open
```

We can use a (tool from the VILLASfpga)[https://git.rwth-aachen.de/acs/public/villas/fpga/fpga/-/blob/master/src/pcimem.c] repo to modify the mapped memory region. The following command will turn on every second LED (170).
```
pcimem /sys/bus/pci/devices/0000\:88\:00.0/resource0 0 b 170
```
