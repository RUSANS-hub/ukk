#!/bin/bash

read -p "Masukan Port (8080): " port
read -p "Masukan Nama: " name
read -p "Masukan Hostname (Tekan Enter Jika Hostname Sama Dengan Nama): " hostname

# Menggunakan nilai name jika hostname tidak diisi
if [ -z "$hostname" ]; then
    hostname=$name
fi


echo "Sedang Menjalankan Nginx & PHP..."
/etc/init.d/nginx start
/etc/init.d/php7.4-fpm start
echo "Nginx & PHP Berhasil Dijalankan!"

# Menjalankan perintah Docker dengan nilai yang diinputkan
echo "Sedang Membuat Container..."
docker run -p "$port:80" --name "$name" -h "$hostname" -di stevegeomet/ukk bash /script.sh

echo "Docker Berhasil Dibuat Dengan Konfigurasi Berikut:"
echo "Port: $port"
echo "Nama: $name"
echo "Hostname: $hostname"

docker exec -it "$name" bash
