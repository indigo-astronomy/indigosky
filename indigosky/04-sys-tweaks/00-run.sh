#!/bin/bash -e

install -m 755 files/rc.local		"${ROOTFS_DIR}/etc/"
install -m 644 files/dphys-swapfile	"${ROOTFS_DIR}/etc/dphys-swapfile"
