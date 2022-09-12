SUMMARY = "peekpoke application by Xilinx"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SRC_URI = "git://github.com/Xilinx/IIoT-EDDP.git;protocol=http;subpath=HLS/ARTY_Z7_FULL/os/petalinux_test/project-spec/meta-user/recipes-apps/peekpoke/files;rev=master"

S = "${WORKDIR}/files"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/peek ${D}${bindir}
    install -m 0755 ${S}/poke ${D}${bindir}
}


