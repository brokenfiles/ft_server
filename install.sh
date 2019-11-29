#!/usr/bin/env bash
# update and upgrade
apt-get update
apt-get upgrade

#installing libs
apt-get -y install mariadb-server
apt-get -y install wget
apt-get -y install php-{mbstring,zip,gd,xml,pear,gettext,cli,fpm,cgi}
apt-get -y install php-mysql
apt-get install -y libnss3-tools
apt-get install -y nginx