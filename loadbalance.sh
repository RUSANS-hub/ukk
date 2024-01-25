#!/bin/bash

# Meminta input dari pengguna
read -p "Masukkan IP Address: " ip_address
read -p "Masukkan Port Web 1: " port_web1
read -p "Masukkan Port Web 2: " port_web2
read -p "Masukkan Nama Web, Contoh 'ruben.ukk.tkj1.smkn4bogor.sch.id : '" web_name

# Membuat isi lb-new.conf
config_content="
upstream backend {
    server $ip_address:$port_web1; #node1
    server $ip_address:$port_web2; #node2
}

server {
    listen 80;
    server_name $ip_address $web_name;

    location / {
        proxy_redirect      off;
        proxy_set_header    X-Real-IP \$remote_addr;
        proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header    Host \$http_host;
        proxy_pass http://backend;
    }
}
"

# Menyimpan isi lb-new.conf ke dalam file
echo "$config_content" > lb-new.conf

# Memindahkan dan mengganti konfigurasi Nginx
cp lb-new.conf /etc/nginx/conf.d/
mv /etc/nginx/conf.d/lb.conf .
cd /etc/nginx/conf.d/
mv lb.conf
mv lb-new.conf lb.conf

# Mereload konfigurasi Nginx
systemctl reload nginx

echo "Konfigurasi lb-new.conf telah berhasil dibuat dan diaktifkan."
