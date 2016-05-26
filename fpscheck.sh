# AV FPS Gauge Script 0.0.1
# this could also be used for Simple CPU benchmarking
# script is crude by nature if you want flashing likes look elsewhere

echo " This script runs with the assumption you have the lastest libav installed on your device"
sudo apt-get install -y libav-tools ubuntu-restricted-extras libavformat-extra-54 imagemagick &
wait $!
mkdir FPSGauge
cd FPSGauge
wget http://www.elecard.com/assets/files/other/clips/Elecard_about_Tomsk_part3_HEVC_1080p.mp4 &
wait $!
wget http://www.elecard.com/assets/files/other/clips/Elecard_about_Tomsk_part3_HEVC_720p.mp4 &
wait $!
mv Elecard_about_Tomsk_part3_HEVC_720p.mp4 720p-src.mp4
mv Elecard_about_Tomsk_part3_HEVC_1080p.mp4 1080p-src.mp4
echo " Starting encoding be sure to document any fps average "
avconv -i 720p-src.mp4 -c:v libx264 720p-out.mp4 &
wait $!
avconv -i 1080p-src.mp4 -c:v libx264 1080p-out.mp4
