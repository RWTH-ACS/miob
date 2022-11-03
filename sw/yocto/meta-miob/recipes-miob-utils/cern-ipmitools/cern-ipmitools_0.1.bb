SUMMARY = "library and python script for interacting with IPMI FMC eeprom"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
SRC_URI = "https://ohwr.org/project/fmc-bus/-/archive/master/fmc-bus-master.zip \
           file://fmc_eeprom_2to3.patch"

SRC_URI[sha256sum] = "f6d2012ce5906ba7eeb4f7f2d351bbbbc56b19ccbf5c50275a01b3c67d89e96e"

RDEPENDS_${PN} += "python3-core"

FILES_${PN} = "\
        ${bindir}/fru-dump \
        ${bindir}/fmc-mem \
        ${bindir}/fmc/libipmi/fmc_eeprom.py \
        ${bindir}/fmc/libipmi/libipmi.so \
"

S = "${WORKDIR}/fmc-bus-master/tools"

TARGET_CC_ARCH += "${LDFLAGS}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 fru-dump ${D}${bindir}
    install -m 0755 fmc-mem ${D}${bindir}
    install -d ${D}${bindir}/fmc/libipmi
    install -m 0755 libipmi/fmc_eeprom.py ${D}${bindir}/fmc/libipmi/
    install -m 0644 libipmi/libipmi.so ${D}${bindir}/fmc/libipmi/
}

