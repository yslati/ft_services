#!/bin/sh
echo "Wordpress Starting ..."
# service nginx start

/usr/sbin/php-fpm7
# rc-service mariadb restart &>/dev/null
nginx -g "daemon off ;"