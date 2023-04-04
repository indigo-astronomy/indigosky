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
dhcp-range=192.168.235.2,192.168.235.235,255.255.255.0,24h
EOL

cat > "${ROOTFS_DIR}/etc/hostapd/hostapd.conf" <<EOL
interface=wlan0
driver=nl80211
ssid=indigosky
hw_mode=g
channel=6
country_code=UK
ieee80211d=1
ieee80211n=1
ieee80211ac=1
wmm_enabled=1
require_ht=1
ht_capab=0
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
net.ipv4.ip_forward=0
EOL

cat >> "${ROOTFS_DIR}/etc/sysctl.conf" <<EOL
net.core.somaxconn=2048
net.ipv4.tcp_max_syn_backlog=512
EOL

cat > "${ROOTFS_DIR}/etc/nftables.conf" <<EOL
#!/usr/sbin/nft -f

flush ruleset

table ip nat {
	chain PREROUTING {
		type nat hook prerouting priority dstnat; policy accept;
	}

	chain INPUT {
		type nat hook input priority 100; policy accept;
	}

	chain OUTPUT {
		type nat hook output priority -100; policy accept;
	}

	chain POSTROUTING {
		type nat hook postrouting priority srcnat; policy accept;
		oifname "eth0" counter packets 1208 bytes 387600 masquerade 
	}
}
EOL

on_chroot << EOF
systemctl enable hostapd
systemctl start hostapd
EOF

on_chroot << EOF
systemctl enable nftables
systemctl start nftables
EOF

on_chroot << EOF
systemctl enable dnsmasq
systemctl start dnsmasq
EOF
