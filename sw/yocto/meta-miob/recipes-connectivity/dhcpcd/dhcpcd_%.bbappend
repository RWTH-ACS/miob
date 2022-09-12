FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

MIOB_DHCPCD_CONF ?= "dhcpcd.conf"

SRC_URI_append = " file://${MIOB_DHCPCD_CONF}"

do_install_append () {
    install -m 0644 ${WORKDIR}/${MIOB_DHCPCD_CONF} ${D}${sysconfdir}
}
