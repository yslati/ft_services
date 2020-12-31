echo "starting ..."
#cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
/usr/sbin/php-fpm7
rc-service mariadb restart &>/dev/null
nginx -g "daemon off ;"