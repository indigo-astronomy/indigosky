#!/bin/bash -e

install -m 755 files/s_rpi_ctrl.sh "${ROOTFS_DIR}/usr/bin/"
install -m 755 files/rpi_ctrl.sh "${ROOTFS_DIR}/usr/bin/"
