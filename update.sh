#!/bin/bash
#update (Wegare)
cek=$(opkg list-installed | awk '{print $1}')
opkg update
# paket sstp
if [[ $cek == *"sstp-client"* ]] && [[ $cek == *"pptpd"* ]]; then
echo > /dev/null
else
opkg install sstp-client pptpd fping
fi
# paket bbr
if [[ $cek == *"kmod-tcp-bbr"* ]]; then
echo > /dev/null
else
opkg install kmod-tcp-bbr
cat <<EOF> /etc/sysctl.conf
# Do not edit, changes to this file will be lost on upgrades
# /etc/sysctl.conf can be used to customize sysctl settings

net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
sysctl -p
fi
# paket l2tp/ipsec
if [[ $cek == *"xl2tpd"* ]] && [[ $cek == *"strongswan-default"* ]]; then
echo > /dev/null
else
opkg install xl2tpd strongswan-default fping
/etc/init.d/ipsec stop 2>/dev/null
/etc/init.d/xl2tpd stop 2>/dev/null
/etc/init.d/ipsec disable 2>/dev/null
/etc/init.d/xl2tpd disable 2>/dev/null
ipsec stop 2>/dev/null
killall -q charon
fi
#paket xray
if [[ $cek == *"openwrt-xray"* ]]; then
echo > /dev/null
else
wget --no-check-certificate "https://github.com/wegare123/vless/blob/main/openwrt-xray_1.3.0-1_aarch64_cortex-a53.ipk?raw=true" -O ~/xray.ipk
opkg install *.ipk fping
fi
# stl
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/stl/main/stl/stl.sh" -O /usr/bin/stl
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/stl/main/stl/gproxy.sh" -O /usr/bin/gproxy
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/stl/main/stl/autorekonek-stl.sh" -O /usr/bin/autorekonek-stl
chmod +x /usr/bin/gproxy
chmod +x /usr/bin/stl
chmod +x /usr/bin/autorekonek-stl
# opvc
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/opvc/main/opvc.sh" -O /usr/bin/opvc
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/opvc/main/autorekonek-opvc.sh" -O /usr/bin/autorekonek-opvc
chmod +x /usr/bin/opvc
chmod +x /usr/bin/autorekonek-opvc
# opvs
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/opvs/main/opvs.sh" -O /usr/bin/opvs
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/opvs/main/autorekonek-opvs.sh" -O /usr/bin/autorekonek-opvs
chmod +x /usr/bin/opvs
chmod +x /usr/bin/autorekonek-opvs
# sst
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/sst/main/sst.sh" -O /usr/bin/sst
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/sst/main/autorekonek-sst.sh" -O /usr/bin/autorekonek-sst
chmod +x /usr/bin/sst
chmod +x /usr/bin/autorekonek-sst
# ssrt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/ssrt/main/ssrt.sh" -O /usr/bin/ssrt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/ssrt/main/autorekonek-ssrt.sh" -O /usr/bin/autorekonek-ssrt
chmod +x /usr/bin/ssrt
chmod +x /usr/bin/autorekonek-ssrt
# tjt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/tjt/main/tjt.sh" -O /usr/bin/tjt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/tjt/main/autorekonek-tjt.sh" -O /usr/bin/autorekonek-tjt
chmod +x /usr/bin/tjt
chmod +x /usr/bin/autorekonek-tjt
# vmt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/vmt/main/vmt.sh" -O /usr/bin/vmt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/vmt/main/autorekonek-vmt.sh" -O /usr/bin/autorekonek-vmt
chmod +x /usr/bin/vmt
chmod +x /usr/bin/autorekonek-vmt
# sstp
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/sstp/main/sstp.sh" -O /usr/bin/sstp
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/sstp/main/autorekonek-sstp.sh" -O /usr/bin/autorekonek-sstp
chmod +x /usr/bin/sstp
chmod +x /usr/bin/autorekonek-sstp
# ram
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/ram/main/ram.sh" -O /usr/bin/ram
chmod +x /usr/bin/ram
# banner
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/banner2" -O /etc/banner2
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/cek.sh" -O /usr/bin/update-tools
chmod +x /etc/banner2
chmod +x /usr/bin/update-tools
# sstp
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/sstp/main/sstp.sh" -O /usr/bin/sstp
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/sstp/main/autorekonek-sstp.sh" -O /usr/bin/autorekonek-sstp
chmod +x /usr/bin/sstp
chmod +x /usr/bin/autorekonek-sstp
# speedtest
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/speedtest/main/speedtest_cli.py" -O /usr/bin/speedtest 
chmod +x /usr/bin/speedtest
# l2tp/ipsec
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/l2i/main/l2i.sh" -O /usr/bin/l2i
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/l2i/main/autorekonek-l2i.sh" -O /usr/bin/autorekonek-l2i
chmod +x /usr/bin/l2i
chmod +x /usr/bin/autorekonek-l2i
# vless
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/vless/main/vless.sh" -O /usr/bin/vless
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/vless/main/autorekonek-vless.sh" -O /usr/bin/autorekonek-vless
chmod +x /usr/bin/vless
chmod +x /usr/bin/autorekonek-vless
# ket
echo "KHUSUS SSTP & L2TP/IPSEC"
echo "Pastikan firewall forwardnya accept"
echo "1. Masuk ke luci"
echo "2. Pilih network"
echo "3. Pilih firewall"
echo "4. Dibagian general setting cari forward lalu ubah bagian bawahnya menjadi accept"
echo "update selesai"
