if [ ! -f "/var/lib/mysql/ib_buffer_pool" ];
then
    /etc/init.d/mariadb setup &>/dev/null
    service mariadb restart &>/dev/null
    echo "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root
	echo "CREATE DATABASE wordpress;" | mysql -u root
	echo "GRANT ALL PRIVILEGES on *.* to 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root
	echo "FLUSH PRIVILEGES;" | mysql -u root
	mysql -u root < wordpress.sql
	mysql -u root < users_data.sql
fi
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
service mariadb restart
/usr/bin/supervisord
#tail -f /dev/null