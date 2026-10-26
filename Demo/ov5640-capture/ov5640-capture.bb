SUMMARY = "ov5640 dma capture + h265 encode"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://ov5640_capture.c \
           file://ov5640_dma.h \
           file://Makefile \
          "

DEPENDS = "gstreamer1.0 \
           gstreamer1.0-plugins-base \
           gstreamer1.0-rtsp-server \
          "

RDEPENDS_${PN} = "gstreamer1.0 \
                  gstreamer1.0-plugins-base \
                  gstreamer1.0-plugins-good \
                  gstreamer1.0-omx \
                  gstreamer1.0-rtsp-server \
                 "

S = "${WORKDIR}"

inherit pkgconfig

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ov5640_capture ${D}${bindir}
}
