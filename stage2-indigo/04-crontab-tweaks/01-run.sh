#!/bin/bash -e

cat > "${ROOTFS_DIR}/etc/cron.d/indigo_wifi_reset" <<EOL
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin
*/30 * * * * indigo s_rpi_ctrl.sh --reset-wifi-server > /dev/null 2>&1
EOL

cat > "${ROOTFS_DIR}/etc/cron.d/indigo_update" <<EOL
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin
@reboot indigo sudo apt-get update > /dev/null 2>&1
EOL

cat >> "${ROOTFS_DIR}/etc/default/cron" <<EOL
EXTRA_OPTS="-l"
EOL
