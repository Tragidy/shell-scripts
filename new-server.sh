#!/bin/bash
# Fresh Server Primer
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on Debian and Ubuntu maybe other debian based distros
# of the same families, although no support is offered for them. It has been 
# designed to be as unobtrusive and universal as possible.

# Clear window, show banner credits
clear

#Secure SSH Right Away
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/^Port .*/Port 25222/g' /etc/ssh/sshd_config
sed -i 's/^ServerKeyBits .*/ServerKeyBits 4096/g' /etc/ssh/sshd_config
service ssh restart

# We Assume this is a new instance/server so we want to go stealth for now 
# Temp IP Table to block ping/icmp, cleared upon reboot
echo "Dropping all ICMP Echo Request for this session"
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP
echo "All ping request are blocked until next reboot"
echo "SSH PORT changed to 25222"
echo "Keybits Changed to 4096"
sleep 1

echo "Starting inital update and upgrade of known packages"
apt-get update -y && apt-get upgrade -y &
wait $!

#Install inital apps, mainly Fail2Ban, we want this running ASAP
echo "Updating and upgrades complete, moving on..."
apt-get install fail2ban -y >/dev/null 2>&1 &
wait $!
echo "Installing common packages"
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl -y >/dev/null 2>&1 &
wait $!

# Extraction and software tools
echo "Installing extraction and container tools"
sudo apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel -y >/dev/null 2>&1 &
wait $!

# Download Firewall and install
cd /usr/src
rm -fv csf.tgz
echo "Downloading and Installing ConfigServerFirewall"
wget https://download.configserver.com/csf.tgz >/dev/null 2>&1 &
wait $!
tar -xzf csf.tgz
cd csf
sh install.sh &
wait $!

# Install Webmin
echo "Downloading Webmin from Source Forge"
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.770_all.deb &
wait $!
echo "Installing Webmin........................"
echo "This can take a long time on ARM or Small VPS systems."
dpkg --install webmin_1.770_all.deb  &
wait $!
echo "Webmin Installation Complete"

# Setup Auto update with cron
echo "30  4  *  *  *  apt-get update -y" >> /etc/crontab/
service webmin restart >/dev/null 2>&1 &
wait $!
service fail2ban restart >/dev/null 2>&1
clear

echo "Script Complete"
echo "Install the firewall webmin module in:"
echo "Webmin > Webmin Configuration > Webmin Modules >"
echo "From local file > /usr/local/csf/csfwebmin.tgz > Install Module"
echo "SSH Port: 25222"
echo "Webmin Port: 10000"
