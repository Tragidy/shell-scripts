# Linux Server Shell Scripts

Scripts for CentOS, Debian, Fedora and Ubuntu

##Fresh Server Script
works with centos/debian based linux.
```
wget -O freshserver.sh https://git.io/vKXBT && bash freshserver.sh
```
This script will install basic security measures such as Fail2Ban and Config Server Firewall
This script will also update your server packages and install webmin for you.

**Packages installed are**

perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libgd-graph-perl unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller axel fail2ban webmin

Optionally reboot your server afterward to unblock ICMP and allow ping, you can now filter it in the CSF firewall.

Want CSF inside webmin?
Install the firewall webmin module in:
Webmin > Webmin Configuration > Webmin Modules >
From local file > /usr/local/csf/csfwebmin.tgz

##Test your CPU for encoding x264 and x265
```
wget -O libav.sh https://git.io/vKXBg && bash libav.sh
```
##LAMP Stack

Installs Apache, MySQL, PHP
```
wget -O lampins.sh https://git.io/vKXBi && bash lampins.sh
```
##ZNC Installer

Downloads, configures and installs ZNC on your machine with options for low memory systems
```
wget -O znci.sh https://git.io/vKXB9 && bash znci.sh
```
