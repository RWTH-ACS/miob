# Xilinx HWServer

The Raspberry Pi of the MIOB can be used to program and debug the Xilinx XZC106 evaluation board remotely via a JTAG USB adapter.
Xilinx standard tool for remote JTAG access is the `hw_server` which unfortunately is only offered for x86/x86_64 Intel systems running Linux.

However, the x86_64 `hw_server` can be executed via QEmu Userspace Emulation also on an ARM-system like the Raspberry Pi.

## Setup

- [Steffens Blog](https://noteblok.net/2022/02/23/running-a-xilinx-hw_server-as-docker-container/)
- [`docker-qemu-interpreter.service`](../sw/docker-qemu-interpreter.service)
