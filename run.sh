#!/bin/bash

echo "1. Buat Container"
echo "2. Buat Index"
echo "3. Konfigurasi Load Balance"
echo "4. Menu lainnya (SSH, Cek Images, DLL)"

echo "Masukan Pilihan :"
read option

case $option in
    1)
        echo "Executing make.sh..."
        ./make.sh
        ;;
    2)
        echo "Executing dir.sh..."
        ./dir.sh
        ;;
    3)
        echo "Executing loadbalance.sh..."
        ./loadbalance.sh
        ;;
    4)
        echo "Executing all.sh..."
        ./all.sh
        ;;
    *)
        echo "Invalid option"
        ;;
esac
