#!/bin/bash
#update (Wegare)
opkg update
sleep 1
wget --no-check-certificate "https://www.dropbox.com/s/lfbaxm8ud37a6kr/stl.sh" -O /usr/bin/stl 
sleep 1
chmod +x /usr/bin/stl
sleep 1
wget --no-check-certificate "https://www.dropbox.com/s/qsml8r53ntcajqa/sst.sh" -O /usr/bin/sst
sleep 1
chmod +x /usr/bin/sst
sleep 1
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/banner2" -O /etc/banner2
sleep 1
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/update/main/cek.sh" -O /usr/bin/update-tools
sleep 1
chmod +x /etc/banner2
sleep 1
chmod +x /usr/bin/update-tools
sleep 1
echo "fix stl method http"
echo "fix sst no plugin"
echo "donasi ovo : 083822389648"
echo "donasi dana : 082318259593"
echo "update selesai"
