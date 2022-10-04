#
# This file is the libxil recipe.
#

SUMMARY = "libxil"
SECTION = "PETALINUX/apps"
LICENSE = "GPL-3.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_BRANCH = "master"

SRC_URI = "git://git.rwth-aachen.de/acs/public/villas/fpga/libxil.git;protocol=https;branch=${SRC_BRANCH};rev=${SRC_BRANCH}"

DEPENDS = ""

RDEPENDS_${PN} = "bash"


FILES_${PN}-dev = "\
        ${includedir}/xilinx \
        ${libdir}/pkgconfig \
"
    
FILES_${PN} = "\
        ${libdir}/libxil.so \
"

S = "${WORKDIR}/git"

inherit pkgconfig cmake


