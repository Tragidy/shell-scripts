# shell-scripts

Scripts for CentOS, Debian, Fedora and Ubuntu

#Test your CPU for encoding x264 and x265

wget https://raw.githubusercontent.com/Tragidy/shell-scripts/master/libav-encoder-test.sh && bash libav-encoder-test.sh

LAMP Stack

wget https://raw.githubusercontent.com/Tragidy/shell-scripts/master/LAMP-INSTALLER.SH && bash LAMP-INSTALLER.SH

Fresh Server Script
works with centos/debian based linux.

wget https://raw.githubusercontent.com/Tragidy/shell-scripts/master/FreshServer.sh && bash FreshServer.sh

This script will install basic security measures such as Fail2Ban and Config Server Firewall
This script will also update your server packages and install webmin for you.

Packages installed are

perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel fail2ban webmin

Optionally reboot your server afterward to unblock ICMP and allow ping, you can now filter it in the CSF firewall.

Want CSF inside webmin?
Install the firewall webmin module in:
Webmin > Webmin Configuration > Webmin Modules >
From local file > /usr/local/csf/csfwebmin.tgz

