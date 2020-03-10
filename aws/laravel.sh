#!/bin/bash

yum -y update
yum -y install epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
### For PHP 7.2 for later just change 72
yum -y --enablerepo=remi-php72 install php php-xml php-soap php-xmlrpc php-mbstring \
                                    php-json php-gd php-mcrypt php-fpm php-zip \
                                    php-curl php-common php-cli php-mysqlnd

# yum -y install php7.2 php7.2-curl php7.2-common php7.2-cli \
#             php7.2-mysql php7.2-mbstring php7.2-fpm php7.2-xml php7.2-zip
yum -y install nginx
yum -y install unzip
yum -y install wget
yum -y install mariadb-server
yum clean all
systemctl start mariadb
systemctl enable mariadb

# mysql_secure_installation.sql
cat > mysql_secure_installation.sql << EOF
# Make sure that NOBODY can access the server without a password
UPDATE mysql.user SET Password=PASSWORD('homestead') WHERE User='root';
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

mysql -sfu root < "mysql_secure_installation.sql"
mysql -u root -phomestead <<MY_QUERY
CREATE DATABASE homestead
GRANT ALL ON homestead.* to 'homestead'@'localhost' IDENTIFIED BY 'secret'
FLUSH PRIVILEGES
MY_QUERY
# curl -sS https://getcomposer.org/installer | \
# php -- --install-dir=/usr/local/bin --filename=composer
# wget https://getcomposer.org/composer.phar
# mv composer.phar /bin/composer

# php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# php composer-setup.php --install-dir=/usr/local/bin --filename=composer

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
chmod +x /usr/bin/composer

mkdir -p /etc/nginx/sites-available/
mkdir -p /etc/nginx/sites-enabled/
cd /var/www/ && composer create-project --prefer-dist laravel/laravel laravel
# chown -R www-data:www-data /var/www/laravel/
# chmod -R 755 /var/www/laravel/

cd /etc/nginx/ && touch sites-available/laravel.conf && \
cat <<EOT >>  sites-available/laravel.conf
server {
         listen 80;
         listen [::]:80 ipv6only=on;
 
         # Log files for Debugging
         access_log /var/log/nginx/laravel-access.log;
         error_log /var/log/nginx/laravel-error.log;
 
         # Webroot Directory for Laravel project
         root /var/www/example.com/public;
         index index.php index.html index.htm;
 
         # Your Domain Name
         server_name example.com;
 
         location / {
                 try_files $uri $uri/ /index.php?$query_string;
         }
 
         # PHP-FPM Configuration Nginx
         location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass unix:/run/php/php-fpm.sock;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
         }
 }
EOT

ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm -f mysql_secure_installation.sql
systemctl restart nginx