#!/bin/bash
# Fresh Server Primer
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on Debian and Ubuntu maybe other debian based distros
# of the same families, although no support is offered for them. It has been 
# designed to be as unobtrusive and universal as possible.

# Clear window, show banner/credits
clear
echo "Starting Quick Node Script"
echo "Script by TRAGiDY"
sleep 3

# We Assume this is a new instance/server so we want to go stealth for now 
# Temp IP Table to block ping/icmp, cleared upon reboot
echo "Dropping all ICMP Ping Request for this session"
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP
echo "All ping request are blocked until next reboot"

#Secure SSH Right Away
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/^Port .*/Port 2222/g' /etc/ssh/sshd_config
sed -i 's/^ServerKeyBits .*/ServerKeyBits 4096/g' /etc/ssh/sshd_config
echo "SSH PORT changed to 2222"
echo "Keybits Changed to 4096"
service ssh restart

echo "Starting inital update and upgrade of known packages"
date;
apt-get update -y && apt-get upgrade -y >/dev/null 2>&1 &
wait $!

#Install inital apps, mainly Fail2Ban, we want this running ASAP
echo "Updating and upgrades complete, moving on..."
apt-get install fail2ban -y >/dev/null 2>&1 &
echo "Fail2Ban Installed an Activated"
wait $!
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl -y >/dev/null 2>&1 &
wait $!
echo "Installed general applications and runtimes"

# Download Firewall and install
cd /usr/src
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz >/dev/null 2>&1 &
wait $!
echo "Downloading and Extracting ConfigServerFirewall"
tar -xzf csf.tgz
cd csf
echo "Going to install CSF"
sh install.sh &
wait $!

# Install Webmin
echo "Downloading Webmin"
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.770_all.deb >/dev/null 2>&1 &
wait $!
echo "Webmin 1.770 Download Completed"
echo "Installing Webmin........................"
dpkg --install webmin_1.770_all.deb &
wait $!
echo "Webmin Installation Complete"
service webmin stop >/dev/null 2>&1 &
echo "Stopping Webmin..."
cp /etc/webmin/miniserv.conf /etc/webmin/miniserv.conf.bak
sed -i 's/^port .*/port=2223/g' /etc/webmin/miniserv.conf
echo "Webmin port changed to 2223"
echo "Installing extraction tools"
sudo apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel rkhunter -y >/dev/null 2>&1 &
wait $!

#Setup Auto update
echo "30  4  *  *  *  apt-get update -y" >> /etc/crontab/
service fail2ban restart
clear

echo "Script Complete"
echo "Installed Fail2Ban, OpenSSL, ConfigServerFirewall, Perl, Python, Axel and Webmin"
echo "Want CSF inside webmin?"
echo "Install the firewall webmin module in:"
echo "Webmin > Webmin Configuration > Webmin Modules >"
echo "From local file > /usr/local/csf/csfwebmin.tgz > Install Module"
echo "SSH Port: 2222"
echo "Webmin Port: 2223"
sleep 5

EOF