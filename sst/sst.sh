#!/bin/bash
#sst (Wegare)
clear
udp2="$(cat /root/akun/sst.txt | grep -i udp | cut -d= -f2)" 
host2="$(cat /root/akun/sst.txt | grep -i host | cut -d= -f2 | head -n1)" 
port2="$(cat /root/akun/sst.txt | grep -i port | cut -d= -f2)" 
bug2="$(cat /root/akun/sst.txt | grep -i bug | cut -d= -f2)" 
pass2="$(cat /root/akun/sst.txt | grep -i pass | cut -d= -f2)" 
enc2="$(cat /root/akun/sst.txt | grep -i enc | cut -d= -f2)" 
uid2="$(cat /root/akun/sst.txt | grep -i uid | cut -d: -f2)" 
publickey2="$(cat /root/akun/sst.txt | grep -i publickey | cut -d: -f2)" 
plugin2="$(cat /root/akun/sst.txt | grep -i plugin | cut -d= -f2)" 
obfs2="$(cat /root/akun/sst.txt | grep -i obfs | cut -d= -f2 | tail -n1)" 
echo "Inject shadowsocks obfs & cloak by wegare"
echo "1. Sett Profile"
echo "2. Start Inject"
echo "3. Stop Inject"
echo "4. Enable auto booting & auto rekonek"
echo "5. Disable auto booting & auto rekonek"
echo "e. exit"
read -p "(default tools: 2) : " tools
[ -z "${tools}" ] && tools="2"
if [ "$tools" = "1" ]; then

echo "Masukkan host/ip" 
read -p "default host/ip: $host2 : " host
[ -z "${host}" ] && host="$host2"

echo "Masukkan port" 
read -p "default port: $port2 : " port
[ -z "${port}" ] && port="$port2"

echo "Masukkan pass" 
read -p "default pass: $pass2 : " pass
[ -z "${pass}" ] && pass="$pass2"

echo "Masukkan bug" 
read -p "default bug: $bug2 : " bug
[ -z "${bug}" ] && bug="$bug2"

read -p "ingin menggunakan port udpgw y/n " pilih
if [ "$pilih" = "y" ]; then
echo "Masukkan port udpgw" 
read -p "default udpgw: $udp2 : " udp
[ -z "${udp}" ] && udp="$udp2"
badvpn="--socks-server-addr 127.0.0.1:1080 --udpgw-remote-server-addr 127.0.0.1:$udp"
elif [ "$pilih" = "Y" ]; then
echo "Masukkan port udpgw" 
read -p "default udpgw: $udp2 : " udp
[ -z "${udp}" ] && udp="$udp2"
badvpn="--socks-server-addr 127.0.0.1:1080 --udpgw-remote-server-addr 127.0.0.1:$udp"
else
badvpn="--socks-server-addr 127.0.0.1:1080"
fi

echo "Masukkan encryption method" 
read -p "default encryption method: $enc2 : " enc
[ -z "${enc}" ] && enc="$enc2"

read -p "ingin menggunakan plugin y/n " pilih2
if [ "$pilih2" = "y" ]; then
echo "Silahkan pilih plugin obfs/cloak" 
read -p "default plugin: $plugin2 : " plugin
[ -z "${plugin}" ] && plugin="$plugin2"
if [ "$plugin" = "obfs" ]; then
echo "Silahkan pilih method obfs http/tls" 
read -p "default plugin: $obfs2 : " obfs
[ -z "${obfs}" ] && obfs="$obfs2"
metode="obfs-local"
plugin_opts="obfs=$obfs;obfs-host=$bug"
elif [ "$plugin" = "cloak" ]; then
echo "Masukkan UID" 
read -p "default UID: $uid2 : " uid
[ -z "${uid}" ] && uid="$uid2"
echo "Masukkan publickey" 
read -p "default publickey: $publickey2 : " publickey
[ -z "${publickey}" ] && publickey="$publickey2"
metode="ck-client"
plugin_opts="UID=$uid;PublicKey=$publickey;ServerName=$bug;BrowserSig=chrome;NumConn=100;ProxyMethod=shadowsocks;EncryptionMethod=plain;StreamTimeout=300"
else 
echo -e "$plugin: invalid selection."
exit
fi
cat <<EOF> /root/akun/sst.json
{
  "server" : "$host",
  "server_port" : "$port",
  "method" : "$enc",
  "password" : "$pass",
  "plugin" : "$metode",
  "plugin_opts" : "$plugin_opts",
  "local_port" : 1080,
  "local_address" : "127.0.0.1",
  "timeout" : 60
}
EOF
else
cat <<EOF> /root/akun/sst.json
{
  "server" : "$host",
  "server_port" : "$port",
  "method" : "$enc",
  "password" : "$pass",
  "local_port" : 1080,
  "local_address" : "127.0.0.1",
  "timeout" : 60
}
EOF
fi


echo "host=$host
port=$port
enc=$enc
pass=$pass
bug=$bug
publickey:$publickey
uid:$uid
plugin=$plugin
obfs=$obfs
udp=$udp" > /root/akun/sst.txt

cat <<EOF> /usr/bin/gproxy-sst
badvpn-tun2socks --tundev tun1 --netif-ipaddr 10.0.0.2 --netif-netmask 255.255.255.0 $badvpn --udpgw-connection-buffer-size 65535 --udpgw-transparent-dns &
EOF
chmod +x /usr/bin/gproxy-sst
echo "Sett Profile Sukses"
sleep 2
clear
/usr/bin/sst
elif [ "${tools}" = "2" ]; then
ipmodem="$(route -n | grep -i 0.0.0.0 | head -n1 | awk '{print $2}')" 
echo "ipmodem=$ipmodem" > /root/akun/ipmodem.txt
udp="$(cat /root/akun/sst.txt | grep -i udp | cut -d= -f2)" 
host="$(cat /root/akun/sst.txt | grep -i host | cut -d= -f2 | head -n1)" 
route="$(cat /root/akun/ipmodem.txt | grep -i ipmodem | cut -d= -f2 | tail -n1)" 

ss-local -c /root/akun/sst.json &
sleep 3
ip tuntap add dev tun1 mode tun
ifconfig tun1 10.0.0.1 netmask 255.255.255.0
/usr/bin/gproxy-sst
route add 8.8.8.8 gw "$route" metric 0
route add 8.8.4.4 gw "$route" metric 0
route add "$host" gw "$route" metric 0
route add default gw 10.0.0.2 metric 0
cat <<EOF> /usr/bin/ping-sst
#!/bin/bash
#sst (Wegare)
while :
do
fping -c1 10.0.0.2
sleep 1
done
EOF
chmod +x /usr/bin/ping-sst
/usr/bin/ping-sst > /dev/null 2>&1 &
elif [ "${tools}" = "3" ]; then
host="$(cat /root/akun/sst.txt | grep -i host | cut -d= -f2 | head -n1)" 
route="$(cat /root/akun/ipmodem.txt | grep -i ipmodem | cut -d= -f2 | tail -n1)" 
#killall screen
killall -q badvpn-tun2socks ss-local ping-sst
route del 8.8.8.8 gw "$route" metric 0 2>/dev/null
route del 8.8.4.4 gw "$route" metric 0 2>/dev/null
route del "$host" gw "$route" metric 0 2>/dev/null
ip link delete tun1 2>/dev/null
killall dnsmasq 
/etc/init.d/dnsmasq start > /dev/null
sleep 2
echo "Stop Suksess"
sleep 2
clear
/usr/bin/sst
elif [ "${tools}" = "4" ]; then
cat <<EOF>> /etc/crontabs/root

# BEGIN AUTOREKONEKSST
*/1 * * * *  autorekonek-sst
# END AUTOREKONEKSST
EOF
sed -i 's/exit 0/ /g' /etc/rc.local
/etc/init.d/cron restart
echo "Enable Suksess"
sleep 2
clear
/usr/bin/sst
elif [ "${tools}" = "5" ]; then
sed -i "/^# BEGIN AUTOREKONEKSST/,/^# END AUTOREKONEKSST/d" /etc/crontabs/root > /dev/null
/etc/init.d/cron restart
echo "Disable Suksess"
sleep 2
clear
/usr/bin/sst
elif [ "${tools}" = "e" ]; then
clear
exit
else 
echo -e "$tools: invalid selection."
exit
fi