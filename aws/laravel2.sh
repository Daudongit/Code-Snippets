#!/bin/bash

yum -y update
yum -y install epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
### For PHP 7.2 for later just change 72
yum -y --enablerepo=remi-php72 install php php-xml php-soap php-xmlrpc php-mbstring \
                                    php-json php-gd php-mcrypt php-fpm php-zip \
                                    php-curl php-common php-cli php-mysqlnd


yum -y install nginx unzip wget mariadb-server mariadb-client
yum clean all
systemctl start mariadb
systemctl enable mariadb

# mysql_secure_installation.sql
cat > mysql_secure_installation.sql << EOF
UPDATE mysql.user SET Password=PASSWORD('homestead') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

mysql -sfu root < "mysql_secure_installation.sql"
mysql -u root -phomestead <<MY_QUERY
CREATE DATABASE homestead;
GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'%' IDENTIFIED BY '8iu7*IU&';
ALTER USER 'homestead'@'%' IDENTIFIED WITH mysql_native_password BY '8iu7*IU&';
FLUSH PRIVILEGES;
MY_QUERY