# Zainuxbrand Ultra pro auto script vpn 

# Directly install without the need to register an IP VPS 

# Order from me (MUST READ) before using

</p> 
<h2 align="center"> Supported Linux Distribution</h2>
<p align="center"><img src="https://d33wubrfki0l68.cloudfront.net/5911c43be3b1da526ed609e9c55783d9d0f6b066/9858b/assets/img/debian-ubuntu-hover.png"></p> 
<p align="center"><img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%209&message=Stretch&color=purple"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%2010&message=Buster&color=purple">  <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2018&message=Lts&color=red"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2020&message=Lts&color=red">
</p>
<p align="center"><img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2022&message=Lts&color=red"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2024&message=Lts&color=red">
</p>

<p align="center"><img src="https://img.shields.io/badge/Service-SSH_Over_Websocket-success.svg"> <img src="https://img.shields.io/badge/Service-SSH_UDP_Custom-success.svg"> <img src="https://img.shields.io/badge/Service-SSH_Dropbear-success.svg">  <img src="https://img.shields.io/badge/Service-Stunnel4-success.svg">  <img src="https://img.shields.io/badge/Service-Fail2Ban-brightgreen">  
<p align="center"><img src="https://img.shields.io/badge/Service-XRAY_VLESS-success.svg">  <img src="https://img.shields.io/badge/Service-XRAY_VMESS-success.svg">  <img src="https://img.shields.io/badge/Service-XRAY_TROJAN-success.svg"> <img src= "https://img.shields.io/badge/Service-Websocket-success.svg"> <img src= "https://img.shields.io/badge/Service-GRPC-success.svg"> <img src= "https://img.shields.io/badge/Service-Shadowsocks-success.svg">  
<p <p align="center"><img src="https://img.shields.io/badge/Service-Webmin-success.svg"> <img src="https://img.shields.io/badge/Service-Helium-success.svg">
<p <p align="center"><img src="https://wangchujiang.com/sb/status/stable.svg">
  
# Required VPS is still fresh (MUST) / have never installed anything
<br>
- If you install the Script twice, you need to rebuild the VPS to factory settings, in the VPS provider panel<br>
- DOMAIN (MUST) / Random<br>
- DEBIAN 9/10<br>
- Ubuntu 18/20/22/24 LTS<br>
- CPU MIN 1 CORE<br>
- RAM 1GB<br>
- (Recommendation) Ubuntu 20 / 22 / 24 LTS (STABLE to use)
<br>

# Ubuntu 20.04 / 22.04 / 24.04 support
<br>
The installer now detects what the running Ubuntu release actually provides and
adapts, so a fresh 20.04, 22.04 or 24.04 VPS installs exactly the same set of
services and ports:
<br>
- **Python** — 20.04 ships `python` (2.7), 22.04 only `python2`, 24.04 has no
  Python 2 at all and falls back to `python3`. The websocket services
  (`ws-dropbear`, `ws-stunnel`) are Python 3, so they run everywhere.
- **libssl** — `libssl1.0-dev` was removed after 20.04; `libssl-dev` is used
  instead.
- **libncurses** — `libncurses5-dev` does not exist on 24.04; `libncurses-dev`
  is used instead.
- **Dropbear** — 22.04/24.04 ship `/etc/default/dropbear` with every line
  commented out, so the usual `sed` edits were silently ignored and dropbear
  stayed on port 22 (clashing with OpenSSH). The installer now appends the real
  values, giving **143 / 109 / 110 / 69 / 50000** on all three releases.
- **netcat** — `netcat` no longer exists on 24.04, which made the whole
  `apt install` line in `xray/ins-xray.sh` fail. `netcat-openbsd` is used
  instead (it is what `netcat` pointed at on 20.04/22.04 anyway).
- **resolvconf** — removed on 24.04 (systemd-resolved replaces it), which made
  the whole `apt install` line in `helium/helium.sh` fail. It is now installed
  only where the release still ships it.
<br>
Package availability is probed with `apt-cache policy` (a missing package
reports `Candidate: (none)`), never with `apt-cache show`, which exits 0 even
for packages that do not exist.
<br>

# Cloudflare settings for those who have their own Domain, you can check at folder [image](https://github.com/zainiking8/AUTO-SCRIPT/tree/master/image) to display other settings
<br>
- SSL/TLS : FULL<br>
- SSL/TLS Recommender : OFF<br>
- GRPC : ON<br>
- WEBSOCKET : ON<br>
- Always Use HTTPS : OFF<br>
- UNDER ATTACK MODE : OFF<br>
<br>

# Pointing
![Pointing](https://github.com/zainiking8/AUTO-SCRIPT/blob/master/image/pointing.png)

## Service & Port:
<br>
- OpenSSH                  : 22<br>
- OpenSSH(JIO5G NO PAYLOAD): 53<br>
- SSH Websocket            : 80<br>
- SSH SSL Websocket        : 443<br>
- Stunnel4                 : 222, 777<br>
- Dropbear                 : 109, 143<br>
- Badvpn                   : 7100-7900<br>
- Nginx                    : 81<br>
- Vmess WS TLS             : 443<br>
- Vless WS TLS             : 443<br>
- Trojan WS TLS            : 443<br>
- Shadowsocks WS TLS       : 443<br>
- Vmess WS none TLS        : 80<br>
- Vless WS none TLS        : 80<br>
- Trojan WS none TLS       : 80<br>
- Shadowsocks WS none TLS  : 80<br>
- Vmess gRPC               : 443<br>
- Vless gRPC               : 443<br>
- Trojan gRPC              : 443<br>
- Shadowsocks gRPC         : 443<br>
<br>
  
## Feature
- Speedtest® by [Ookla®](https://speedtest.net)
- Set Auto Reboot
- Restart All Service
- AUTO delete user Expired 
- Check Bandwith
- BBRPLUS version 1.4.0 by [Chikage0o0](https://github.com/Chikage0o0) What is BBR [Search now BBR](https://www.google.com/search?q=what+bbr+in+linux)
- DNS CHANGER
- no auto backup? which... is permanently removed
- Just accept the existing features / you can add them yourself manually
- Additional Features (Optional) skipper (NOTE) install after [Step Install] is complete
- Optional [install OpenVPN + Slowdns +](https://github.com/zainiking8/AUTO-SCRIPT/tree/master/udp-custom) UDP-Custom by [Exe302](https://gitlab.com/Exe302) + Slowdns by [SL](https://github.com/fisabiliyusri)
- Optional [install Panel Webmin + ADS Block](https://github.com/zainiking8/AUTO-SCRIPT/tree/master/helium) Helium version 3.0 by [Abi Darwish](https://github.com/abidarwish)
- Optional [install Bot Telegram Xolpanel](https://github.com/zainiking8/AUTO-SCRIPT/tree/master/bot%20telegram%20panel) by [XolvaID](https://github.com/XolvaID)
  
# Menu
![Service Status](https://github.com/zainiking8/AUTO-SCRIPT/blob/master/image/menu1.png)

# Service Status
![Service Status](https://github.com/zainiking8/AUTO-SCRIPT/blob/master/image/service1.png)

# [Step Install]
- Step 1 for (debian) please update first
```
apt update && apt upgrade -y && reboot
```
- Step 2 for (ubuntu) directly install
```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/zainiking8/AUTO-SCRIPT/master/setup1.sh && chmod +x setup1.sh && sed -i -e 's/\r$//' setup1.sh && screen -S setup ./setup1.sh
```

# Telegram
[![Telegram-chat](https://img.shields.io/badge/Chat-Telegram-blue)](https://t.me/zainuxbrand7/)
[![Telegram-grup](https://img.shields.io/badge/Grup-Telegram-blue)](https://t.me/+1p9RnexGMP0yOGVl/)

# ATTENTION (MUST READ) CAREFULLY
- PROHIBITED FOR SALE BECAUSE I GET FREE FROM THE INTERNET
- DATA SECURITY / YOUR USE HISTORY ON THE INTERNET IS NOT MY RESPONSIBILITY AS A SCRIPT PROVIDER
- ALL YOUR DATA / USAGE HISTORY ON THE INTERNET ONLY VPS NETWORK PROVIDERS MANAGE IT AND (FBI) maybe
- USE IT WISELY THEN YOU WILL AVOID PROBLEMS
- WATCHING ADULT FILM IS YOUR OWN RESPONSIBILITY

# FINAL MESSAGE
- THANK YOU FOR TAKING THE TIME TO READ AND SORRY IF THERE ARE IMPACT WORDS
- BECAUSE I AM ALSO A HUMAN WHO DOESN'T ESCAPE FROM MISTAKES
