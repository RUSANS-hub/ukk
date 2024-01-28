read -p "Masukan Nama Container1: " nama
read -p "Masukan Nama Container2: " nama2
read -p "Masukan Port Container2: " port

echo "Sedang Mencopy Images..."
docker commit $nama foxy_images
echo "Berhasil Mencopy!"
docker images
echo "Membuat Container 2..."
docker run -p $port:80 --name $nama2 --hostname $hostname2 -i -t foxy_images
echo "Selesai!"
