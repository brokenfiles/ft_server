#!/usr/bin/env bash
# update and upgrade
apt-get update
apt-get upgrade -y

#disabling harmless warnings
export DEBIAN_FRONTEND="noninteractive"

#installing libs
apt-get -y install mariadb-server
apt-get -y install wget
apt-get -y install php-{mbstring,zip,gd,xml,pear,gettext,cli,fpm,cgi}
apt-get -y install php-mysql
apt-get -y install nginx

#ssl setup
mkdir ~/mkcert
cd ~/mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
./mkcert -install
./mkcert localhost

#setup nginx
cd
mkdir -p /var/www/localhost
cp /home/nginx-host-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

#setup database
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
mysql wordpress -u root --password= < /home/wordpress.sql

#installing wordpress
cd
cp /home/wordpress.tar.gz /var/www/localhost/
cd /var/www/localhost/
tar -xf wordpress.tar.gz
rm wordpress.tar.gz
cd wordpress
cd ../

#installing phpmyadmin
cd
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
mkdir /var/www/localhost/phpmyadmin
tar xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin
cp /home/config.inc.php /var/www/localhost/phpmyadmin/

#allowing nginx user
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

#services
service mysql restart
/etc/init.d/php7.3-fpm start
service nginx restart

echo "Build finished."
