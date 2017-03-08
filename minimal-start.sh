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
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP

echo "Starting inital update and upgrade of known packages"
if [[ "$OS" = 'debian' ]]; then
apt-get update -y && apt-get upgrade -y &
wait $!
apt-get install dialog -y
wait $!

#Install inital apps
echo "Updating and upgrades moving on..."
apt-get install fail2ban apt-utils ca-certificates -y
wait $!
echo "Installing common packages"
apt-get install git axel perl libnet-ssleay-perl openssl python gcc ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev -y
wait $!

# Setup Auto update with cron
echo "30  4  *  *  *  apt-get update -y" >> /etc/crontab/
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
