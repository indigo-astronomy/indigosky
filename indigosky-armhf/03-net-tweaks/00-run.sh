#!/bin/bash -e

install -m 644 files/hostname "${ROOTFS_DIR}/etc/hostname"
install -m 644 files/hosts "${ROOTFS_DIR}/etc/hosts"
install -m 600 files/indigo-wifi.nmconnection "${ROOTFS_DIR}/etc/NetworkManager/system-connections"
install -m 644 files/NetworkManager.conf "${ROOTFS_DIR}/etc/NetworkManager"

cat > "${ROOTFS_DIR}/etc/dnsmasq.conf" <<EOL
interface=wlan0
dhcp-range=192.168.235.2,192.168.235.235,255.255.255.0,24h
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
systemctl disable nftables
systemctl stop nftables
EOF

on_chroot << EOF
systemctl disable dnsmasq
systemctl stop dnsmasq
EOF
