if [ ! -f "/var/lib/mysql/ib_buffer_pool" ];
then
    /etc/init.d/mariadb setup &> /dev/null
    service mariadb restart &> null
    echo "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root
	echo "CREATE DATABASE wordpress;" | mysql -u root
	echo "GRANT ALL PRIVILEGES on *.* to 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root
	echo "FLUSH PRIVILEGES;" | mysql -u root
fi
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
service mariadb restart
# /usr/bin/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=root

tail -F /dev/null