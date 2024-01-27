#!/bin/bash

read -p "Masukan Port (8080): " port
read -p "Masukan Nama: " name
read -p "Masukan Hostname (Tekan Enter Jika Hostname Sama Dengan Nama): " hostname

# Menggunakan nilai name jika hostname tidak diisi
if [ -z "$hostname" ]; then
    hostname=$name
fi

# Menjalankan perintah Docker dengan nilai yang diinputkan
docker run -p "$port:80" --name "$name" -h "$hostname" -di stevegeomet/ukk bash /script.sh

echo "Masukan Konfigurasi Docker:"
echo "Port: $port"
echo "Nama: $name"
echo "Hostname: $hostname"

docker exec -it "$name" bash
