SUMMARY = "utility to program the fmc eeprom"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SRC_BRANCH = "main"
SRCREV = "${AUTOREV}"
SRC_URI = "git://github.com/RWTH-ACS/dino.git;protocol=https;branch=main"

# fru-generator needs python 2. I hate to include this into the image
# We should port fru-generator to pyhton 3 at some point
#DEPENDS += "python"
RDEPENDS_${PN} += "cern-ipmitools"
RDEPENDS_${PN} += "python3-core"

FILES_${PN} = "\
        ${bindir}/fmceeprom_write \
        ${bindir}/fmc/fru-generator.py \
"

S = "${WORKDIR}/git/hw/fpga-fmc/eeprom"

TARGET_CC_ARCH += "${LDFLAGS}"

do_install() {
        oe_runmake install 'DESTDIR=${D}/usr'
}

