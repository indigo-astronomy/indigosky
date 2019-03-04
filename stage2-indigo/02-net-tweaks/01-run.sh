#!/bin/bash -e

install -m 644 files/hostname "${ROOTFS_DIR}/etc/hostname"
install -m 644 files/hosts "${ROOTFS_DIR}/etc/hosts"

cat >> "${ROOTFS_DIR}/etc/dhcpcd.conf" <<EOL
interface wlan0
static ip_address=192.168.235.1/24
nohook wpa_supplicant
EOL

cat > "${ROOTFS_DIR}/etc/dnsmasq.conf" <<EOL
interface=wlan0
dhcp-range=192.168.235.2,192.168.235.20,255.255.255.0,24h
EOL

cat > "${ROOTFS_DIR}/etc/hostapd/hostapd.conf" <<EOL
interface=wlan0
driver=nl80211
ssid=indigosky
hw_mode=g
channel=6
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=indigosky
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOL

cat >> "${ROOTFS_DIR}/etc/default/hostapd" <<EOL
DAEMON_CONF="/etc/hostapd/hostapd.conf"
EOL

cat >> "${ROOTFS_DIR}/etc/sysctl.conf" <<EOL
net.ipv4.ip_forward=1
EOL

cat > "${ROOTFS_DIR}/etc/iptables.ipv4.nat" <<EOL
*nat
:PREROUTING ACCEPT [1:122]
:INPUT ACCEPT [1:122]
:OUTPUT ACCEPT [1:168]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o eth0 -j MASQUERADE
COMMIT
EOL

on_chroot << EOF
systemctl enable hostapd
systemctl start hostapd
EOF

on_chroot << EOF
systemctl enable dnsmasq
systemctl start dnsmasq
EOF
