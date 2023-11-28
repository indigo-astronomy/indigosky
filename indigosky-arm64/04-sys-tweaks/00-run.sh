#!/bin/bash -e

echo '# Enable PWM for the RPi GPIO driver' >>"${ROOTFS_DIR}/boot/config.txt"
echo 'dtoverlay=pwm-2chan' >>"${ROOTFS_DIR}/boot/config.txt"

echo '# Enable poweroff from GPIO pins' >>"${ROOTFS_DIR}/boot/config.txt"
echo 'dtoverlay=gpio-shutdown,gpio_pin=7,active_low=1,gpio_pull=up' >>"${ROOTFS_DIR}/boot/config.txt"
echo 'dtoverlay=gpio-poweroff,gpiopin=8,active_low=1' >>"${ROOTFS_DIR}/boot/config.txt"

echo '[pi4]' >>"${ROOTFS_DIR}/boot/config.txt"
echo '# Run as fast as firmware / board allows' >>"${ROOTFS_DIR}/boot/config.txt"
echo 'arm_boost=1' >>"${ROOTFS_DIR}/boot/config.txt"


install -m 755 files/rc.local		"${ROOTFS_DIR}/etc/"
install -m 644 files/dphys-swapfile	"${ROOTFS_DIR}/etc/dphys-swapfile"
