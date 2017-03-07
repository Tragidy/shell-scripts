#!/bin/bash
# NAT Server Primer
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will Debian maybe other distros
# of the same families, although no support is offered for them. It has been 
# designed to be as unobtrusive and universal as possible.

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


echo "Starting inital update and upgrade of known packages"
if [[ "$OS" = 'debian' ]]; then
echo "Starting inital update and upgrade of known packages"
apt-get update -y && apt-get upgrade -y &
wait $!

#Install inital apps, mainly Fail2Ban, we want this running ASAP
echo "Updating and upgrades complete, moving on..."
apt-get install fail2ban -y >/dev/null 2>&1 &
wait $!
echo "Installing common packages"
apt-get install ca-certificates perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl -y >/dev/null 2>&1 &
wait $!

# Extraction and software tools
echo "Installing extraction and container tools"
sudo apt-get install git unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel -y >/dev/null 2>&1 &
wait $!

sudo apt-get install gcc git ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev -y >/dev/null 2>&1 &
wait $!

# Setup Auto update with cron
echo "30  4  *  *  *  apt-get update -y" >> /etc/crontab/
service fail2ban restart >/dev/null 2>&1
clear

echo "Script Complete"

mkdir installer
cd installer
wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
wait $!
git clone https://github.com/wpscanteam/wpscan.git
wait $!
cd wpscan
wait $!
sudo gem install bundler && bundle install --without test

fi
