#!/bin/bash

yum localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
yum install -y mysql-community-server

# start mysql service
service mysqld start

# get Temporary root Password
root_temp_pass=$(grep 'A temporary password' /var/log/mysqld.log |tail -1 |awk '{split($0,a,": "); print a[2]}')

echo "root_temp_pass:"$root_temp_pass

# mysql_secure_installation.sql
cat > mysql_secure_installation.sql << EOF
# Make sure that NOBODY can access the server without a password
UPDATE mysql.user SET Password=PASSWORD('8iu7*IU&') WHERE User='root';
# Kill the anonymous users
DELETE FROM mysql.user WHERE User='';
# disallow remote login for root
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# Kill off the demo database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# Make our changes take effect
FLUSH PRIVILEGES;
EOF

#mysql -uroot -p"$root_temp_pass" --connect-expired-password <mysql_secure_installation.sql

#As you already stopped the service, go to /etc/my.cnf and add skip-grant-tables right after [mysql] (line below)
systemctl stop mysqld
echo 'skip-grant-tables'>>'/etc/my.cnf'
systemctl start mysqld
mysql -uroot  <mysql_secure_installation.sql
sed -i_bkp  '$ d' /etc/my.cnf
# sed -i '$ d' /etc/my.cnf
systemctl restart mysqld
rm -f mysql_secure_installation.sql
