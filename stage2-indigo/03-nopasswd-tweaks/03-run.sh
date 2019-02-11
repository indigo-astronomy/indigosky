#!/bin/bash -e

install -m 440 files/010_indigopi-nopasswd "${ROOTFS_DIR}/etc/sudoers.d/"
