#!/bin/bash
#update (Wegare)
opkg update && opkg install wget curl
# stl
wget --no-check-certificate "https://github.com/wegare123/update/blob/main/stl/stl.sh" -O /usr/bin/stl
chmod +x /usr/bin/stl
# sst
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/sst/sst.sh" -O /usr/bin/sst
chmod +x /usr/bin/sst
# banner
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/banner2" -O /etc/banner2
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/cek.sh" -O /usr/bin/update-tools
chmod +x /etc/banner2
chmod +x /usr/bin/update-tools
echo "fix stl method http"
echo "fix sst no plugin"
echo "donasi ovo: 083822389648"
echo "donasi dana: 082318259593"
echo "update selesai"
