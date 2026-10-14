#!/bin/bash

# Ensure the script is run as root
if [ "${EUID}" -ne 0 ]; then
    echo "You need to run this script as root"
    sleep 5
    exit 1
fi

# Check virtualization
if [ "$(systemd-detect-virt)" == "openvz" ]; then
    echo "OpenVZ is not supported"
    sleep 5
    exit 1
fi

# Create necessary directories and files
mkdir -p /etc/xray /etc/v2ray
touch /etc/xray/domain /etc/v2ray/domain /etc/xray/scdomain /etc/v2ray/scdomain

# Update and install required packages (Ubuntu 20/22/24 compatible)
apt-get update
# libncurses5-dev exists on 20.04/22.04 but is gone on 24.04 -> libncurses-dev
# NB: `apt-cache show` exits 0 even for missing packages, so use
# `apt-cache policy`, which reports "Candidate: (none)" reliably.
_pkg_available() { apt-cache policy "$1" 2>/dev/null | grep -q "Candidate: [0-9]"; }
NCURSES="libncurses-dev"
if _pkg_available libncurses5-dev; then
    NCURSES="libncurses5-dev libncursesw5-dev"
fi
apt-get install -y software-properties-common build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm $NCURSES xz-utils tk-dev libffi-dev liblzma-dev git dos2unix

# Python (Ubuntu 20/22/24 compat)
#   20.04 -> "python"  (python2.7)
#   22.04 -> "python2" (the plain "python" package was removed)
#   24.04 -> "python3" (python2 is gone from the archive entirely)
if _pkg_available python; then
    apt-get install -y python
elif _pkg_available python2; then
    apt-get install -y python2
    [ -x /usr/bin/python2 ] && ln -sf /usr/bin/python2 /usr/bin/python
else
    # 24.04: no python2 at all — use python3 and symlink
    apt-get install -y python3
    [ -x /usr/bin/python3 ] && ln -sf /usr/bin/python3 /usr/bin/python
fi

# Domain configuration
echo "1. Use Our NT Domain Random"
echo "2. Choose Your Own Domain"
read -rp "Input 1 or 2: " dns
if [ "$dns" -eq 1 ]; then
    # Download cf script and convert line endings
    wget https://raw.githubusercontent.com/zainiking8/AUTO-SCRIPT/master/ssh/cf
    dos2unix cf
    bash cf
elif [ "$dns" -eq 2 ]; then
    read -rp "Enter Your Domain: " dom
    echo "$dom" > /var/lib/ipvps.conf
    echo "$dom" > /root/scdomain
    echo "$dom" > /etc/xray/scdomain
    echo "$dom" > /etc/xray/domain
    echo "$dom" > /etc/v2ray/domain
    echo "$dom" > /root/domain
else
    echo "Not Found Argument"
    exit 1
fi

# Install services
wget -q https://raw.githubusercontent.com/zainiking8/AUTO-SCRIPT/master/ssh/ssh-vpn.sh
dos2unix ssh-vpn.sh
bash ssh-vpn.sh

wget -q https://raw.githubusercontent.com/zainiking8/AUTO-SCRIPT/master/xray/ins-xray.sh
dos2unix ins-xray.sh
bash ins-xray.sh

wget -q https://raw.githubusercontent.com/zainiking8/AUTO-SCRIPT/master/sshws/insshws.sh
dos2unix insshws.sh
bash insshws.sh

# Setup environment for auto-reboot
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Log setup
mkdir -p /var/lib/
echo "IP=" >> /var/lib/ipvps.conf
# Fix: if user entered domain via option 2, ipvps.conf already has it.
#   Make sure format is correct (IP=domain, not bare domain)
if [ -n "$dom" ] && [ -f /var/lib/ipvps.conf ]; then
    # If first line is not "IP=...", prepend it
    if ! head -1 /var/lib/ipvps.conf | grep -q "^IP="; then
        DomVal=$(head -1 /var/lib/ipvps.conf)
        sed -i "1s|^.*|IP=${DomVal}|" /var/lib/ipvps.conf 2>/dev/null || echo "IP=${DomVal}" > /var/lib/ipvps.conf
    fi
fi

# Installation summary
echo "===================================="
echo " _   _ _______     ______  _   _ "
echo "| \ | |_   _\ \   / /  _ \| \ | |"
echo "|  \| | | |  \ \ / /| |_) |  \| |"
echo "| |\  | | |   \ V / |  __/| |\  |"
echo "|_| \_| |_|    \_/  |_|   |_| \_|"
echo "===================================="        
echo "Services and Ports:"
echo " - OpenSSH: 22"
echo " - SSH Websocket: 80"
echo " - SSH SSL Websocket: 443"
echo " - Stunnel4: 222, 777"
echo " - Dropbear: 109, 143"
echo " - Badvpn: 7100-7900"
echo " - Nginx: 81"
echo " - Vmess WS TLS: 443"
echo " - Vless WS TLS: 443"
echo " - Trojan WS TLS: 443"
echo " - Shadowsocks WS TLS: 443"
echo " - Vmess WS none TLS: 80"
echo " - Vless WS none TLS: 80"
echo " - Trojan WS none TLS: 80"
echo " - Shadowsocks WS none TLS: 80"
echo " - Vmess gRPC: 443"
echo " - Vless gRPC: 443"
echo " - Trojan gRPC: 443"
echo " - Shadowsocks gRPC: 443"
echo "=================================================================="
echo "Contact: https://t.me/zainuxbrand7"
echo "=================================================================="

# Additional commands (non-fatal — external repos may 404, must not break install)
bash <(curl -Ls https://raw.githubusercontent.com/lalfulsk/Auto/main/dnsdisable.sh) 2>/dev/null || true
wget -O /root/log-install.txt https://github.com/zainiking8/SCRIPTS/raw/main/log-install.txt 2>/dev/null || true
bash <(curl -Ls https://raw.githubusercontent.com/lalfulsk/NT-A.I.O/main/dropbearconfig.sh) 2>/dev/null || true
bash <(curl -Ls https://raw.githubusercontent.com/lalfulsk/NT-A.I.O/main/dropbear.sh) 2>/dev/null || true
bash <(curl -Ls https://github.com/zainiking8/AUTO-SCRIPTS/raw/main/swap.sh) 2>/dev/null || true
systemctl start dropbear 2>/dev/null || true
systemctl enable dropbear 2>/dev/null || true

# [Ubuntu 24.04 compat] ssh.socket takes port 22 away from ssh.service
#   SAFETY: only disable socket AFTER confirming ssh.service works
if systemctl list-unit-files 2>/dev/null | grep -q '^ssh.socket'; then
    systemctl enable ssh.service >/dev/null 2>&1 || true
    if systemctl start ssh.service 2>/dev/null; then
        systemctl disable --now ssh.socket >/dev/null 2>&1 || true
    fi
fi
systemctl restart ssh >/dev/null 2>&1 || true

# Cleanup and reboot
rm -f /root/setup.sh /root/ins-xray.sh /root/insshws.sh cf ssh-vpn.sh ins-xray.sh insshws.sh
echo "Auto reboot in 40 seconds..."
sleep 40

# Reboot
reboot
