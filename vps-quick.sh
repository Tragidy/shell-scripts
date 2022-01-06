#!/bin/bash
# Simple VPS Primer
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# Debian 10 supported only.

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
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP

echo "Starting inital update and upgrade of known packages"
if [[ "$OS" = 'debian' ]]; then
apt update -y && apt upgrade -y &
wait $!
apt-get install dialog -y
wait $!

#Install inital apps
echo "Updating and upgrades moving on..."
apt install fail2ban apt-utils ca-certificates apt-transport-https -y
wait $!
echo "Added TOR Sources"
deb https://deb.torproject.org/torproject.org stretch main
wait $!
deb-src https://deb.torproject.org/torproject.org stretch main
wait $!
gpg2 --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 
wait $!
gpg2 --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
echo "Installing common packages"
apt install git axel perl libnet-ssleay-perl openssl python gcc ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev -y
wait $!

# Setup Auto update with cron
echo "30  4  *  *  *  apt update -y" >> /etc/crontab/
service fail2ban restart >/dev/null 2>&1

echo ""
	echo "Do you want to install OpenVPN now?"
	echo "   1) Yes"
	echo "   2) No"
	read -p "CONFOP [1-2]: " -e -i 1 CONFOP
	echo ""
	
	case $CONFOP in
		1)
echo "Starting OpenVPN Wizard"
mkdir vpn
cd vpn
wget https://git.io/vpn -O ovpn.sh && bash opvpn.sh
wait $!
echo "Script Complete"
		;;
		2)
echo "Script Complete"
		;;
	esac

fi
