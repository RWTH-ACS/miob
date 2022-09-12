FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

MIOB_REGS_INIT ?= "regs.init"

SRC_URI_append = " file://${MIOB_REGS_INIT}"

do_compile_prepend() {
    if ! grep -q "[init]regs.init" ${BIF_FILE_PATH}; then
        echo "patching boot.bif to include SMMU register init."
        cp ${WORKDIR}/${MIOB_REGS_INIT} ${B}
        sed -i 's/}/\t \[init\]regs.init\n}/' ${BIF_FILE_PATH}
    fi
}
