FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SYSTEM_USER_DTSI ?= "smmu.dtsi"
BOARD_DTSI ?= "BOARD/zcu106-reva.dtsi"
BOARD_DTSI_PATH ?= "device_tree/data/kernel_dtsi/2021.1"

SRC_URI_append = " file://${SYSTEM_USER_DTSI} \
                   git://github.com/Xilinx/device-tree-xlnx.git;protocol=https;branch=xlnx_rel_v2021.1"

do_configure_append() {
        cp ${WORKDIR}/${SYSTEM_USER_DTSI} ${B}/device-tree
        cp -r ${WORKDIR}/git/${BOARD_DTSI_PATH}/* ${B}/device-tree
        echo "/include/ \"${SYSTEM_USER_DTSI}\"" >> ${B}/device-tree/system-top.dts
        #echo "#include \"${BOARD_DTSI}\"" >> ${B}/device-tree/system-top.dts
        sed -i '/^#include \"pcw\.dtsi\"$/a #include \"${BOARD_DTSI}\"' ${B}/device-tree/system-top.dts
}
