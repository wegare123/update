#!/bin/bash
#update (Wegare)
cek="$(curl 'https://raw.githubusercontent.com/wegare123/update/main/banner2' -s | grep -i versi | awk '{print $7}')" 
cek2="$(cat /etc/banner2 | grep -i versi | awk '{print $7}')" 
if [ "$cek" = "$cek2" ]; then
echo "VERSI TOOLS SUDAH TERBARU!!!"
else
bash -c "$(wget -O- https://raw.githubusercontent.com/wegare123/update/main/update.sh)"
fi
				