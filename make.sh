#!/bin/bash

read -p "Enter port: " port
read -p "Enter name: " name
read -p "Enter hostname (press Enter to use the same value as name): " hostname

# Menggunakan nilai name jika hostname tidak diisi
if [ -z "$hostname" ]; then
    hostname=$name
fi

# Menjalankan perintah Docker dengan nilai yang diinputkan
docker run -p "$port:80" --name "$name" -h "$hostname" -di stevegeomet/web bash /script.sh

echo "Docker container has been started with the following configuration:"
echo "Port: $port"
echo "Name: $name"
echo "Hostname: $hostname"

docker exec -it "$name" bash
