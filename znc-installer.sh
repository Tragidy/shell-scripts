#!/bin/bash
# ZNC INSTALLER from Source
# By TRAGiDY https://github.com/Tragidy/
# Downloads, Compiles and Installs ZNC

# First we check for root
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit 1
fi

# Are you running Debian?
if [[ -e /etc/debian_version ]]; then
OS=debian
apt-get update -y &
wait $!
apt-get install build-essential libssl-dev libperl-dev libicu-dev -y &
wait $!
fi

# Create working space
rm -rf zncinstaller
mkdir zncinstaller
cd zncinstaller
wget https://znc.in/releases/znc-1.6.6.tar.gz &
wait $!
tar -xzvf znc*.*gz &
wait $!
cd znc*
clear
echo ""
	echo "Please select a configuration option"
	echo "   1) Standard Build and Installtion"
	echo "   2) Low Memory Build and Installation"
	read -p "CONFOP [1-2]: " -e -i 1 CONFOP
	echo ""
	
	case $CONFOP in
		1)
echo "Configuring ZNC with basic/stock options"
./configure &
wait $!
echo "Configure complete, getting read to build from source"
echo "Building from source... This may take some time please wait"
make >/dev/null 2>&1 &
wait $!
echo "Build Complete!"
make install >/dev/null 2>&1 &
echo "Installing ZNC to system"
wait $!
echo "Build Complete!"
echo "Under any account on the system please issue the command znc --makeconf to create a znc client for this user."
		;;
		2)
echo "Configuring ZNC for a low memory system"
./configure --disable-optimization CXXFLAGS="--param ggc-min-expand=2 --param ggc-min-heapsize=20000" &
wait $!
echo "Configure complete, getting read to build from source"
echo "Building from source... This will take a long time"
make >/dev/null 2>&1 &
wait $!
echo "Build Complete!"
make install >/dev/null 2>&1 &
echo "Installing ZNC to system"
wait $!
echo "Build Complete!"
echo "Under any account on the system please issue the command znc --makeconf to create a znc client for this user."
		;;
	esac



