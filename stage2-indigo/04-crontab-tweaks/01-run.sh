#!/bin/bash -e

install -m 600 files/indigo "${ROOTFS_DIR}/var/spool/cron/crontabs"

on_chroot << EOF
chown indigo.crontab /var/spool/cron/crontabs/indigo
EOF
