#!/bin/bash

show_docker_list() {
    echo "1. List Semua Docker"
    docker ps -a
}

copy_docker_container() {
    echo "2. Copy Docker Yang Sudah Ada"
    docker ps -a
    read -p "Masukkan Container ID yang ingin di-copy: " container_id
    read -p "Masukkan nama untuk image baru: " image_name
    docker commit "$container_id" "$image_name"
}

check_images() {
    echo "3. Cek Apakah Images Sudah Ada"
    docker images
}

start_nginx_php() {
    echo "4. Jalankan Nginx & PHP"
    /etc/init.d/nginx start
    /etc/init.d/php7.4-fpm start
}

generate_ssh_key() {
    echo "5. ssh-keygen"
    ssh-keygen
}

ssh_without_password_linux() {
    echo "6. SSH Tanpa Password Command Linux"
    read -p "Masukkan path kunci SSH (default: ~/.ssh/id_rsa): " ssh_path
    read -p "Masukkan port SSH: " ssh_port
    read -p "Masukkan IP tujuan: " ssh_ip
    ssh-copy-id -i "$ssh_path" -p "$ssh_port" ubuntu@"$ssh_ip"
}

ssh_without_password_windows() {
    echo "Copas Code Ini Pada CMD"
    echo '$env:USERPROFILE/.ssh/id_rsa.pub | ssh ubuntu@{ip} -p {port} "cat >> .ssh/authorized_keys"'
}

delete_container() {
    echo "8. Hapus Container"
    docker ps -a
    read -p "Masukan Nama Kontainer: " container_name
    echo "Sedang Menghentikan $container_name"
    docker stop "$container_name"
    echo "Sedang Menghapus $container_name"
    docker rm "$container_name"
    echo "Operasi Berhasil!"
    
    docker ps -a
}

delete
# Main script
PS3="Masukkan nomor pilihan: "
options=("List Semua Docker" "Copy Docker Yang Sudah Ada" "Cek Apakah Images Sudah Ada" "Jalankan Nginx & PHP" "ssh-keygen" "SSH Tanpa Password Command Linux" "SSH Tanpa Password Command Windows" "Hapus Container" "Keluar")

select option in "${options[@]}"
do
    case $option in
        "List Semua Docker")
            show_docker_list
            ;;
        "Copy Docker Yang Sudah Ada")
            copy_docker_container
            ;;
        "Cek Apakah Images Sudah Ada")
            check_images
            ;;
        "Jalankan Nginx & PHP")
            start_nginx_php
            ;;
        "ssh-keygen")
            generate_ssh_key
            ;;
        "SSH Tanpa Password Command Linux")
            ssh_without_password_linux
            ;;
        "SSH Tanpa Password Command Windows")
            ssh_without_password_windows
            ;;
        "Hapus Container")
            delete_container
            ;;
        "Keluar")
            echo "Terima kasih, sampai jumpa!"
            break
            ;;
        *)
            echo "Pilihan tidak valid. Silakan pilih kembali."
            ;;
    esac
done
