#!/bin/bash
# Encoder Testing
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on any CentOS Bases or Debian Based linux.


# Detect "sh" instead of bash for debian user
# Thanks Nyr for the help
if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "This script needs to be run with bash"
	exit 1
fi

#Check OS
if [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
elif [[ -e /etc/debian_version ]]; then
	OS=debian
else
	echo "Looks like you aren't running this installer on a RedHat or CentOS system"
	exit 4
fi

if [[ "$OS" = 'debian' ]]; then
apt-get install libav-tools -y &
wait $!
else
yum install libav-tools -y &
wait $!
fi

echo ""
	echo "What Video Source do you want to work with?"
	echo "   1) x264 480P"
	echo "   2) x264 720P"
	echo "   3) X264 1080P"
	echo "   4) X265 1080P"
	echo "   5) X265 4K"
	read -p "VID [1-5]: " -e -i 1 VID
	echo ""

case $VID in
		1)
		wget -O sample.mp4 http://download.openbricks.org/sample/H264/big_buck_bunny_480p_H264_AAC_25fps_1800K.MP4 &
		wait $!
		avconv -i sample.mp4 -c:v libx264 -strict experimental sample-out.mp4 &
		wait $!
		;;
		2)
		wget -O sample.mp4 http://download.openbricks.org/sample/H264/big_buck_bunny_720p_H264_AAC_25fps_3400K.MP4 &
		wait $!
		avconv -i sample.mp4 -c:v libx264 -strict experimental sample-out.mp4 &
		wait $!
		;;
		3)
		wget -O sample.mp4 http://download.openbricks.org/sample/H264/big_buck_bunny_1080p_H264_AAC_25fps_7200K.MP4 &
		wait $!
		avconv -i sample.mp4 -c:v libx264 -strict experimental sample-out.mp4 &
		wait $!
		;;
		4)
		wget -O sample.mp4 https://s3.amazonaws.com/x265.org/video/Tears_400_x265.mp4 &
		wait $!
		avconv -i sample.mp4 -c:v libx264 -strict experimental sample-out.mp4 &
		wait $!
		;;
		5)
		wget -O sample.mkv http://downloads.4ksamples.com/downloads/sample-Elysium.2013.2160p.mkv &
		wait $!
		avconv -i sample.mkv -c:v libx264 -strict experimental sample-out.mp4 &
		wait $!
		;;
	esac
	
	#cleanup
        rm -rf sample.mkv sample.mp4 sample-out.mp4 sample-out.mkv
	echo "Encoding complete please note the time to complete the task or fps"
