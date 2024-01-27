#!/bin/bash

read -p "mkdir /var/www/html/" dir
read -p "Pilih Untuk index.php:
1. Hostname Doang
2. Custom Text
3. Hostname + Custom Text (container1 iniCustomText)
4. Custom Text + Hostname (iniCustomText container1)
Enter your choice (1/2/3/4): " choice

# Membuat direktori
mkdir "/var/www/html/$dir"

# Membuat berkas index.php dan menyesuaikan kontennya berdasarkan pilihan
case $choice in
    1)
        echo "<?php echo ' ' . gethostname() . ' '; ?>" > "/var/www/html/$dir/index.php"
        ;;
    2)
        read -p "Enter custom text: " text
        echo "<?php echo \"$text\" . ' '; ?>" > "/var/www/html/$dir/index.php"
        ;;
    3)
        read -p "Enter custom text: " text
        echo "<?php echo ' ' . gethostname() . ' ' . \"$text\" . ' '; ?>" > "/var/www/html/$dir/index.php"
        ;;
    4)
        read -p "Enter custom text: " text
        echo "<?php echo '$text ' . gethostname() . ' '; ?>" > "/var/www/html/$dir/index.php"
        ;;
    *)
        echo "Invalid choice. Please enter a valid option (1/2/3/4)."
        exit 1
        ;;
esac


echo "index.php has been created in /var/www/html/$dir with the chosen content."

#!/bin/bash

read -p "Ubah Direktori Sekarang? (y/n): " change

if [ "$change" == 'y' ]; then
    nano /etc/nginx/sites-available/default
elif [ "$change" == 'n' ]; then
    echo "Tidak Mengubah Direktori, Untuk Mengubah Manual Silakan Masuk Ke 'nano /etc/nginx/sites-available/default'."
else
    echo "Pilihan tidak valid."
fi

echo "Restarting Server..."
nginx -t
/etc/init.d/nginx restart
echo "Success Restarting Server..."
