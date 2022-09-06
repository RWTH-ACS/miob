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
                          fpga-manager \
                          petalinux-ocicontainers"

# EXTRA RECIPES
## Select recipes from meta-oe to install on top of the base image
CORE_IMAGE_EXTRA_INSTALL_append = "ntp \
                                   ldd \
                                   htop \
                                   can-utils \
                                   cmake \
                                   net-snmp \
                                   git \
                                   sssd \
                                   autofs \
                                   vim"
