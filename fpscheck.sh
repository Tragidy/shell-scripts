# AV FPS Gauge Script 0.0.1
# this could also be used for Simple CPU benchmarking
# script is crude by nature if you want flashing likes look elsewhere

echo " This script runs with the assumption you have the lastest libav installed on your device"
sudo apt-get install -y libav-tools ubuntu-restricted-extras libavformat-extra-54 imagemagick
mkdir FPSGauge
cd FPSGauge
wget http://www.elecard.com/assets/files/other/clips/Elecard_about_Tomsk_part3_HEVC_1080p.mp4
