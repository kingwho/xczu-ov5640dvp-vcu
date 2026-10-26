SUMMARY = "Recipe for  build an external ov5640-dma Linux kernel module"
SECTION = "PETALINUX/modules"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module
INHIBIT_PACKAGE_STRIP = "1"

SRC_URI = "file://Makefile \
		file://ov5640_dma.c \
		file://ov5640_init.c \
           	file://ov5640_init.h \
		file://ov5640_dma.h    \
	   	file://COPYING"
S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.
