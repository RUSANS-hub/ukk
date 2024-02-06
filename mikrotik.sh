read -p "Masukan Identity Mikrotik: " identity
read -p "Masukan Interface Internet (ether1): " eth1
read -p "Masukan Interface Komputer (ether2): " eth2
read -p "Masukan Ip Inteface Komputer (172.16.10.1/28): " ip1
read -p "Masukan Ip Inteface Wlan/Wifi (172.10.10.1/29): " ip2
read -p "Masukan SSID Wifi: " ssid
read -p "Masukan User Hotspot 1 (staff): " user1
read -p "Masukan Bandwidth Untuk User1 (5m): " bw1
read -p "Masukan Password User1: " pw_usr1
read -p "Masukan User Hotspot 2 (public): " user2
read -p "Masukan Bandwidth Untuk User2 (5m): " bw2
read -p "Masukan Password User1: " pw_usr2
read -p "Masukan Website Firewall (ruben.ukk.tkj1.smkn4bogor.sch.id): " website
read -p "Masukan Nama Untuk address List: " list

echo "


"
echo "Copy Paste Kode Dibawah Ini Pada Terminal Mikrotik:

"

echo "========================================================================================================================================================="
echo "/system identity set name=$identity;/ip dhcp-client add interface=$eth1 disabled=no;/ip address add address=$ip1 interface=$eth2;/ip firewall nat add chain=srcnat out-interface=all-ethernet action=masquerade;/ip address add address=$ip2 interface=wlan1;interface wireless enable wlan1;interface wireless set mode=ap-bridge ssid=$ssid numbers=0;ip hotspot setup;ip hotspot user profile add name=$user1 rate-limit=$bw1;ip hotspot user profile add name=$user2 rate-limit=$bw2 address-list=ip_public;ip hotspot user add name=$user1 password=$pw_usr1 profile=$user1;ip hotspot user add name=$user2 password=$pw_usr2 profile=$user2;ip hotspot profile set login-by=http-chap numbers=1;ip firewall address-list add address=$website list=$list;ip firewall filter add chain=forward  protocol=tcp dst-port="80,443" in-interface=wlan1 src-address-list=ip_public dst-address-list=!$list action=drop "
echo "========================================================================================================================================================="
