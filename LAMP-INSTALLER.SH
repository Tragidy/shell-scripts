#!/bin/bash
# Easy LAMP for RHEL, CentOS and Fedora based linux.
# By TRAGiDY https://github.com/Tragidy/
# 
# Released Under Apache 2.0 License 
# http://www.apache.org/licenses/LICENSE-2.0

# This script will work on Redhat  maybe other debian based distros
# of the same families, although no support is offered for them. It has been 
# designed to be as unobtrusive and universal as possible.

# init
# Clear window, show banner credits
clear


echo "Making sure system and repos are updated"
yum update -y &
wait $!

# Apache2
echo "Installing latest version of Apache in your repo."
yum install httpd httpd-devel -y >/dev/null 2>&1 &
wait $!
echo "Starting Apache"
/etc/init.d/httpd start &
wait $!

# SQL
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
