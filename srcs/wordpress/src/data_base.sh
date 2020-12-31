#!bin/sh

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES on wordpress.* to 'admin'@'localhost' IDENTIFIED BY 'admin';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "EXIT" | mysql -u root