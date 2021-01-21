#!/bin/bash
#update (Wegare)
opkg update && opkg install wget
# stl
wget -O /usr/bin/stl "https://www.dropbox.com/s/lfbaxm8ud37a6kr/stl.sh"
chmod +x /usr/bin/stl
# sst
wget -O /usr/bin/sst "https://www.dropbox.com/s/qsml8r53ntcajqa/sst.sh"
chmod +x /usr/bin/sst
# banner
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/banner2" -O /etc/banner2
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/cek.sh" -O /usr/bin/update-tools
chmod +x /etc/banner2
chmod +x /usr/bin/update-tools
echo "fix stl method http"
echo "fix sst no plugin"
echo "donasi ovo : 083822389648"
echo "donasi dana : 082318259593"
echo "update selesai"
