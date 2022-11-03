SUMMARY = "fru tools application by Analog Devices"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SRC_BRANCH = "master"
SRC_URI = "git://github.com/analogdevicesinc/fru_tools.git;protocol=https;rev=master"

FILES_${PN} = "\
        ${bindir}/fru-dump \
        ${libdir}/fmc-tools \
        ${mandir}/man1/fru-dump.1 \
"

S = "${WORKDIR}/git"

TARGET_CC_ARCH += "${LDFLAGS}"

do_install() {
        oe_runmake install 'DESTDIR=${D}/usr'
}

