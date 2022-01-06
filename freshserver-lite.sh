#!/bin/bash
# Fresh Server Lite no Firewall or Webmin
# Have a new dedicated? or vps? this will complete some of the most basic tasks.
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on RHEL and Debian maybe other distros
# of the same families, although no support is offered for them. It has been 
# designed to be as unobtrusive and universal as possible.
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

#Secure SSH Right Away
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/^Port .*/Port 42022/g' /etc/ssh/sshd_config
sed -i 's/^ServerKeyBits .*/ServerKeyBits 4096/g' /etc/ssh/sshd_config
systemctl restart ssh

# We Assume this is a new instance/server so we want to go stealth for now 
# Temp IP Table to block ping/icmp, cleared upon reboot
echo "Dropping all ICMP Echo Request for this session"
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP
echo "All ICMP Echo request are blocked"
echo "SSH PORT changed to 42022"
echo "Keybits Changed to 4096"
sleep 1

echo "Starting inital update and upgrade of known packages"
if [[ "$OS" = 'debian' ]]; then
echo "Starting inital update and upgrade of known packages"
apt update -y && apt upgrade -y &
wait $!

#Install inital apps, mainly Fail2Ban, we want this running ASAP
echo "Updating and upgrades complete, moving on..."
apt install fail2ban -y >/dev/null 2>&1 &
wait $!
echo "Installing common packages"
apt-get install ca-certificates perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl -y >/dev/null 2>&1 &
wait $!

# Extraction and software tools
echo "Installing extraction and container tools"
sudo apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel -y >/dev/null 2>&1 &
wait $!

# Setup Auto update with cron
echo "30  4  *  *  *  apt update -y" >> /etc/crontab/
systemctl restart ssh >/dev/null 2>&1 &
wait $!
service fail2ban restart >/dev/null 2>&1
clear

echo "Script Complete"
echo "SSH Port: 42022"
else
yum update -y && yum upgrade -y &
wait $!
yum install epel-release -y  &
wait $!
yum install iptables openssl wget ca-certificates -y  &
wait $!
yum update -y &
wait $!
echo "Updating and upgrades complete, moving on..."
yum install fail2ban -y >/dev/null 2>&1 &
wait $!
echo "Installing common packages"
yum install perl perl-Net-SSLeay openssl perl-IO-Tty-y >/dev/null 2>&1 &
wait $!

# Extraction and software tools
echo "Installing extraction and container tools"
yum install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel  -y >/dev/null 2>&1 &
wait $!

# Setup Auto update with cron
echo "30  4  *  *  *  yum update -y" >> /etc/crontab/
service fail2ban restart >/dev/null 2>&1
clear

echo "Script Complete"
echo "SSH Port: 42022"
				fi
