# shell-scripts
Server Script for first login

Fresh Server Script
works with centos/debian based linux.

wget https://raw.githubusercontent.com/Tragidy/shell-scripts/master/FreshServer.sh && bash FreshServer.sh


LAMP Stack

wget https://raw.githubusercontent.com/Tragidy/shell-scripts/master/LAMP-INSTALLER.SH && bash LAMP-INSTALLER.SH

This script will install basic security measures such as Fail2Ban and Config Server Firewall
This script will also update your server packages and install webmin for you.

Packages installed are

perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl

unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel 

fail2ban webmin

This script is for use on a fresh server or instance.

Optionally reboot your server afterward to unblock ICMP and allow ping, you can now filter it in the CSF firewall.

Want CSF inside webmin?
Install the firewall webmin module in:
Webmin > Webmin Configuration > Webmin Modules >
From local file > /usr/local/csf/csfwebmin.tgz

