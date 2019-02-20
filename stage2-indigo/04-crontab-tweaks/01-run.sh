#!/bin/bash -e

cat >> "${ROOTFS_DIR}/etc/cron.d/indigo" <<EOL
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin
*/30 * * * * s_rpi_ctrl.sh --reset-wifi-server > /dev/null 2>&1
EOL
