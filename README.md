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
```
What Video Source do you want to work with?
   1) x264 480P
   2) x264 720P
   3) X264 1080P
   4) X265 1080P
   5) X265 4K
VID [1-5]: 1
```

##ZNC Installer

Downloads, configures, compiles from source with options for low memory systems
```
wget -O znci.sh https://git.io/vKXB9 && bash znci.sh
```
```
Please select a configuration option
   1) Standard Build and Installtion
   2) Low Memory Build and Installation
CONFIG [1-2]: 1
```

