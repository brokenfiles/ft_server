FROM		debian:buster

COPY		srcs/install.sh ./

RUN			bash install.sh

#CMD		service mysql start && \
#			nginx -g 'daemon off;'

EXPOSE		80 443

# apt-get update
# apt-get upgrade
# apt install nginx
# service nginx start
# echo "deb http://deb.debian.org/debian stretch main
  #> deb-src http://deb.debian.org/debian stretch main
  #>
  #> deb http://deb.debian.org/debian stretch-updates main
  #> deb-src http://deb.debian.org/debian stretch-updates main
  #>
  #> deb http://security.debian.org/debian-security/ stretch/updates main
  #> deb-src http://security.debian.org/debian-security/ stretch/updates main" >> etc/apt/sources.list
# apt-get install phpmyadmin << y,yes,user,user,1
#
#
#