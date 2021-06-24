#!/bin/bash -e

# Enable PWM for the RPi GPIO driver
echo 'dtoverlay=pwm-2chan' >>"${ROOTFS_DIR}/boot/config.txt"

install -m 755 files/rc.local		"${ROOTFS_DIR}/etc/"
install -m 644 files/dphys-swapfile	"${ROOTFS_DIR}/etc/dphys-swapfile"
