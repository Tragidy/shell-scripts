#!/bin/bash
# Encoder Testing
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on any linux/bash/posix with libav installed


# Detect "sh" instead of bash for debian user
# Thanks Nyr for the help
if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "This script needs to be run with bash"
	exit 1
fi
#cleanup
rm -rf sample.mkv sample.mp4 sample-out.mp4 sample-out.mkv

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
		wget http://download.openbricks.org/sample/H264/big_buck_bunny_480p_H264_AAC_25fps_1800K.MP4 &
		wait $!
		mv big_buck_bunny_480p_H264_AAC_25fps_1800K.MP4 sample.mp4
		avconv -i sample.mp4 -c:v libx264 sample-out.mp4 &
		wait $!
		;;
		2)
		wget http://download.openbricks.org/sample/H264/big_buck_bunny_720p_H264_AAC_25fps_3400K.MP4 &
		wait $!
		mv big_buck_bunny_720p_H264_AAC_25fps_3400K.MP4 sample.mp4
		avconv -i sample.mp4 -c:v libx264 sample-out.mp4 &
		wait $!
		;;
		3)
		wget http://download.openbricks.org/sample/H264/big_buck_bunny_1080p_H264_AAC_25fps_7200K.MP4 &
		wait $!
		mv big_buck_bunny_1080p_H264_AAC_25fps_7200K.MP4 sample.mp4
		avconv -i sample.mp4 -c:v libx264 sample-out.mp4 &
		wait $!
		;;
		4)
		wget https://s3.amazonaws.com/x265.org/video/Tears_400_x265.mp4 &
		wait $!
		mv Tears_400_x265.mp4 sample.mp4
		avconv -i sample.mp4 -c:v libx264 sample-out.mp4 &
		wait $!
		;;
		5)
		wget http://downloads.4ksamples.com/downloads/sample-Elysium.2013.2160p.mkv &
		wait $!
		mv sample-Elysium.2013.2160p.mkv sample.mkv
		avconv -i sample.mkv -c:v libx264 sample-out.mp4 &
		wait $!
		;;
	esac
	
	
