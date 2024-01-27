#!/bin/bash

read -p "Masukan Directory: /var/www/html/" dir
read -p "Pilih Content Untuk index.php:
1. Hostname Doang (container1)
2. Custom Text (IniCustomText)
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

read -p "Ubah Direktori Sekarang? (y/n): " change

if [ "$change" == 'y' ]; then
    mkdir -p backup
    cp /etc/nginx/sites-available/default backup/
    cd /etc/nginx/sites-available/
    rm default
    config_content=$(cat <<EOF
        ##
        # You should look at the following URL's in order to grasp a solid understanding
        # of Nginx configuration files in order to fully unleash the power of Nginx.
        # https://www.nginx.com/resources/wiki/start/
        # https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
        # https://wiki.debian.org/Nginx/DirectoryStructure
        #
        # In most cases, administrators will remove this file from sites-enabled/ and
        # leave it as reference inside of sites-available where it will continue to be
        # updated by the nginx packaging team.
        #
        # This file will automatically load configuration files provided by other
        # applications, such as Drupal or Wordpress. These applications will be made
        # available underneath a path with that package name, such as /drupal8.
        #
        # Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
        ##

        # Default server configuration
        #
        server {
            listen 80 default_server;
            listen [::]:80 default_server;

            root /var/www/html/$dir;  # Adjusted this line

            # Add index.php to the list if you are using PHP
            index index.php index.html index.htm index.nginx-debian.html;

            server_name _;

            location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files \$uri \$uri/ =404;
            }

            # pass PHP scripts to FastCGI server
            #
            location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
            }

            # deny access to .htaccess files, if Apache's document root
            # concurs with nginx's one
            #
            # location ~ /\.ht {
            #    deny all;
            # }
        }
EOF
)
    echo "$config_content" > default
elif [ "$change" == 'n' ]; then
    echo "Tidak Mengubah Direktori, Untuk Mengubah Manual Silakan Masuk Ke 'nano /etc/nginx/sites-available/default'."
else
    echo "Pilihan tidak valid."
fi

echo "Restarting Server..."
nginx -t
service nginx restart
echo "Success Restarting Server..."
