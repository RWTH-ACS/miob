notes:

The size of the register space of devices needs to be larger than the page size.
With vfio_platform, each IP is a separate linux device, and VFIO requires each device's memory space to be larger than the page size to allow mmio / mmap that device, because otherwise multiple devices could map into the same page.
Thus, the FPGA design needs to assign each device at least 4 KiB memory.
