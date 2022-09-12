SUMMARY = "Test VFIO and SMMU with a simple DMA application"
DESCRIPTION = ""
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "https://xilinx-wiki.atlassian.net/wiki/download/attachments/18841981/vfiotest;downloadfilename=vfiotest.c \
           file://miob-mods.patch"

SRC_URI[sha256sum] = "fcc2e3b6264b9f70ae6ec4af708a5aeee84d80358bfe7c7c205b937a5cbe7c23"

S = "${WORKDIR}"

do_compile() {
        ${CC} ${LDFLAGS} vfiotest.c -o vfiotest
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 vfiotest ${D}${bindir}
}
