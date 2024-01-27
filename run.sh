#!/bin/bash

echo "1. Buat Container"
echo "2. Konfigurasi Load Balance"
echo "8. Menu lainnya (SSH, Cek Images, DLL)"

echo "Masukan Pilihan :"
read option

case $option in
    1)
        echo "Executing make.sh..."
        ./one.sh
        ;;
    2)
        echo "Executing loadbalance.sh..."
        ./two.sh
        ;;
    8)
        echo "Executing all.sh..."
        ./all.sh
        ;;
    *)
        echo "Invalid option"
        ;;
esac
