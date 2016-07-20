#!/bin/bash
# ZNC INSTALLER from Source
# By TRAGiDY https://github.com/Tragidy/
# Downloads, Compiles and Installs ZNC

# Clear window, show banner credits
clear

# Check for root
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit 1
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	RCLOCAL='/etc/rc.d/rc.local'
	# Needed for CentOS 7
	chmod +x /etc/rc.d/rc.local
else
	echo "Looks like you aren't running this installer on a Debian or CentOS system"
	exit 4
fi

# Create a clean working space
rm -rf zncinstaller
mkdir zncinstaller
cd zncinstaller
wget http://znc.in/releases/znc-1.6.3.tar.gz &
wait $!
tar -xzvf znc*.*gz &
wait $!
cd znc*
echo ""
	echo "Please select a configuration option"
	echo "   1) Standard Build and Installtion"
	echo "   2) Low Memory Build and Installation"
	read -p "CONFOP [1-2]: " -e -i 1 CONFOP
	echo ""
	
	case $VID in
		1)
echo "Configuring ZNC with basic/stock options"
./configure >/dev/null 2>&1 &
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
echo "Configuring ZNC with basic/stock options"
./configure >/dev/null 2>&1 &
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
	esac



