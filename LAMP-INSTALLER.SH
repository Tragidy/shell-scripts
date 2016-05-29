#!/bin/bash
# Easy LAMP for RHEL, CentOS and Fedora based linux.
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on Redhat  maybe other debian based distros
# of the same families, although no support is offered for them. It has been 
# designed to be as unobtrusive and universal as possible.

# Clear window, show banner credits
clear

# Check for root
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit 1
fi

# Ensure release can be maintained
if grep -qs "CentOS release 4" "/etc/redhat-release"; then
	echo "CentOS 4 is too old and not supported"
	exit 3
fi

if [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	RCLOCAL='/etc/rc.d/rc.local'
	# Needed for CentOS 7
	chmod +x /etc/rc.d/rc.local
else
	echo "Looks like you aren't running this installer on a RedHat or CentOS system"
	exit 4
fi


echo "Making sure system and repos are updated"
yum update -y &
wait $!

# Apache2
echo "Installing latest version of Apache in your repo."
yum install httpd httpd-devel -y >/dev/null 2>&1 &
wait $!
/etc/init.d/httpd start &
wait $!

# mySQL
echo "Installing mySQL you will be prompted to set a mysql root password"
yum install mysql mysql-server mysql-devel -y &
wait $!

# PHP
echo "Installing PHP"
yum install php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml -y &
wait $!
/etc/init.d/httpd restart &
wait $!


echo "LAMP Stack is complete"
