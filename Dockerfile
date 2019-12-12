FROM		debian:buster

COPY		srcs/install.sh /home
COPY		srcs/nginx-host-conf /home
COPY		srcs/config.inc.php /home
COPY		srcs/wordpress.sql /home
COPY		srcs/wordpress.tar.gz /home

RUN			bash /home/install.sh

CMD			service mysql restart && \
			service php7.3-fpm start && \
			nginx -g 'daemon off;'

EXPOSE		80 443