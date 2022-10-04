#
# This file is the VILLASnode recipe.
#

SUMMARY = "VILLASnode co-simulation gateway"
SECTION = "PETALINUX/apps"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_BRANCH = "master"
SRC_URI = "gitsm://git.rwth-aachen.de/acs/public/villas/node.git;protocol=https;rev=master;bareclone=0"

DEPENDS = "coreutils-native fmt spdlog jansson libwebsockets util-linux mosquitto nanomsg zeromq libnl rabbitmq-c libconfig openssl curl libxil"

RDEPENDS_${PN} = "bash"

FILES_${PN}-dev = "\
        ${includedir}/villas \
		${libdir}/pkgconfig \
		${datadir}/pkgconfig \
        ${libdir}/libvillas.so \
        ${libdir}/libvillas-common.so \
"

FILES_${PN} = "\
        ${prefix}/etc/villas/ \
        ${datadir}/villas/ \
        ${libexecdir}/villas/node/plugins/libexample_hook.so \
        ${libdir}/libvillas-common.so.* \
        ${libdir}/libvillas.so.* \
        ${libdir}/libvillas-fpga.so \
        ${bindir}/villas \
        ${bindir}/villas-* \
        ${bindir}/rmshm \
        ${bindir}/rmsem \
"

S = "${WORKDIR}/git"

EXTRA_OECMAKE += "-DWITH_TESTS=OFF"

inherit pkgconfig cmake
