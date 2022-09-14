DESCRIPTION = "Image for MIOB development"
HOMEPAGE = "https://github.com/RWTH-ACS/miob"
LICENSE = "Apache-2.0"

# Base this image on petalinux-image-minimal
require recipes-core/images/petalinux-image-common.inc

# IMAGE FEATURES
## Select package groups as defined in core-image and petalinux-image-common

### Remove dropbear because we want to use openssh instead
IMAGE_FEATURES_remove = "ssh-server-dropbear"
IMAGE_FEATURES_append = " debug-tweaks \
                          ssh-server-openssh \
                          tools-debug \
                          petalinux-networking-stack \
                          petalinux-networking-debug \
                          petalinux-utils \
                          petalinux-lmsensors \
                          fpga-manager"

### Add package management
IMAGE_FEATURES_append = " package-management"
PACKAGE_CLASSES = "package_rpm"
PACKAGE_FEED_URIS = "http://package.fein-aachen.org/yocto"
PACKAGE_FEED_BASE_PATHS = "rpm"
PACKAGE_FEED_ARCHS = "aarch64"

# EXTRA RECIPES
## Select recipes from meta-oe to install on top of the base image
MIOB_BASE_INSTALL = "dhcpcd \
                     ntp \
                     ldd \
                     htop \
                     can-utils \
                     cmake \
                     net-snmp \
                     git \
                     sssd \
                     autofs \
                     vim \
                     openvpn \
                     dnf"
MIOB_EXTRA_INSTALL = "vfiotest \
                      peekpoke"

CORE_IMAGE_EXTRA_INSTALL_append = " ${MIOB_BASE_INSTALL} \
                                    ${MIOB_EXTRA_INSTALL}"
