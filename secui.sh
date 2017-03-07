#!/bin/bash
# Self Scanning Installer
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# Debian maybe other distros

# Check for root
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit 1
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	RCLOCAL='/etc/rc.local'
else
	echo "Looks like you aren't running this installer on a Debian or CentOS system"
	exit 4
fi


echo "Starting inital update and upgrade of known packages"
if [[ "$OS" = 'debian' ]]; then
echo "Starting inital update and upgrade of known packages"
apt-get update -y && apt-get upgrade -y &
wait $!

#Install inital apps
echo "Updating and upgrades complete, moving on..."
apt-get install fail2ban -y
wait $!
echo "Installing common packages"
apt-get install ca-certificates git zip unzip p7zip-full p7zip-rar sharutils axel perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl python libgd-graph-perl -y
wait $!

sudo apt-get install gcc ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev -y
wait $!

# Setup Auto update with cron
echo "30  4  *  *  *  apt-get update -y" >> /etc/crontab/
service fail2ban restart >/dev/null 2>&1

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
