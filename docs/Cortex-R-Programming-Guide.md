# MIOB

ZCU106 Eval Board

Featuring the Zynq UltraScale+ XCZU7EV-2FFVC1156 MPSoC

## Raspberry

Raspberry ist JTAG Host, Login im PW-Repo unter `acs_pw/hw/devices/miob-rpi`:
```sh
ssh pi@miob-{0-5}.acs-lab.eonerc.rwth-aachen.de
```

Raspberry works as a bridge for xilinx tools

## Programming

Install Vitis 2021.2

1. Create New Application Project
2. Create a new platform from hardware (XSA)
3. Select `zcu106`
4. Select `psu_cortexr5_0`
5. Set application project name
6. Select `psu_cortexr5_0`
7. Select example (e.g., hello world)
8. Modify `platform.spr`
    - psu_cortexr5_0 -> standalone_psu_cortexr5->Board Support Package
    - Modify BSP Settings
    - _standalone->stdin_: psu_coresight_0 for JTAG UART (vitis console)
    - _standalone->stdin_: psu_uart0 for /dev/ttyUSB0 console
9. right click platform -> Build Platform (every time the platform is changed)
10. right click project -> Build Project
11. Modify _run configurations_
    - Single Application Debug
    - Debug Type: :Single Application Project
    - Connection -> New:
        - Host: `miob-3.acs-lab.eonerc.rwth-aachen.de`
    - make sure in Application `psu_cortexr5_0` is selected
    - make sure in Target Setup `reset RPU` is selected
12. Run/Debug
13. For printf via IDE: Console->Display Selected Console->TCF Debug [...] Core 0

To read stdout from UART0 on the raspberry:

```sh
sudo picocom --baud 115200 --flow n /dev/ttyUSB0
```
## Use Vitis running on a VM

If you installed Vitis in a VM you can use X-Forwarding to use it:
```
ssh -Y user@address
source /path/to/vitis/Vitis/2021.2/settings64.sh
/path/to/vitis/Vitis/2021.2/bin/vitis
```

## Rust

**WIP**

There is a Makefile for building the application.

xsdb can be run with tcl script for flashing.

 ```tcl
connect -path [list tcp::1534 tcp:miob-3 blablabla ]
 ```

## FPGA Programming:

Maybe: https://github.com/trabucayre/openFPGALoader
