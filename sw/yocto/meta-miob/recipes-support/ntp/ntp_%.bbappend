FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
 
MIOB_NTP_CONFIG ?= "ntp.conf"
 
SRC_URI_append = " file://${MIOB_NTP_CONFIG}"

do_install_append() {
    install -m 644 ${WORKDIR}/${MIOB_NTP_CONFIG} ${D}${sysconfdir}/ntp.conf
}
