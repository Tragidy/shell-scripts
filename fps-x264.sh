# AV FPS Gauge Script 0.0.1
# this could also be used for Simple CPU benchmarking
# script is crude by nature if you want flashing likes look elsewhere

echo " This script runs with the assumption you have the lastest libav installed on your device"
sudo apt-get install -y libav-tools &
wait $!
mkdir FPSGauge-x264
cd FPSGauge-x264
wget http://jell.yfish.us/media/jellyfish-10-mbps-hd-h264.mkv &
wait $!
wget http://www.elecard.com/assets/files/other/clips/Elecard_about_Tomsk_part3_HEVC_720p.mp4 &
wait $!
mv jellyfish-10-mbps-hd-h264.mkv 1080p-src.mp4
echo " Starting encoding be sure to document any fps average 1080p 30FPS 5MBps "
wait $!
avconv -i 1080p-src.mp4 -c:v libx264 1080p-out.mp4
