#!/bin/bash -e

install -m 644 files/indigo.service "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF
systemctl enable indigo
EOF

on_chroot << EOF
systemctl start indigo
EOF
