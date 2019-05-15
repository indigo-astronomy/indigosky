#!/bin/bash -e

install -m 644 files/neofetch.conf      "${ROOTFS_DIR}/etc/"
install -m 644 files/indigosky_logo.txt "${ROOTFS_DIR}/etc/"

echo "neofetch --config /etc/neofetch.conf" >> "${ROOTFS_DIR}/home/indigo/.bashrc"
