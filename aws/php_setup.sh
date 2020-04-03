#update
yum update -y

#install basic app
yum install -y curl wget vim git unzip socat bash-completion epel-release

#install php repo
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

#install php and extension
yum install -y php72w php72w-cli php72w-fpm php72w-mysqlnd php72w-curl php72w-sqlite3 php72w-mbstring php72w-gd php72w-xml
#start php-fpm sevice
systemctl start php-fpm.service
systemctl enable php-fpm.service


# #ssl setup
# #sudo su - root
# git clone https://github.com/Neilpang/acme.sh.git
# cd acme.sh 
# ./acme.sh --install --accountemail your_email@example.com
# source ~/.bashrc
# cd ~

# # RSA 2048
# acme.sh --issue --standalone -d example.com --keylength 2048
# # ECDSA
# acme.sh --issue --standalone -d example.com --keylength ec-256

# mkdir -p /etc/letsencrypt/example.com
# sudo mkdir -p /etc/letsencrypt/example.com_ecc

# # RSA
# acme.sh --install-cert -d example.com \ 
#         --cert-file /etc/letsencrypt/example.com/cert.pem \
#         --key-file /etc/letsencrypt/example.com/private.key \
#         --fullchain-file /etc/letsencrypt/example.com/fullchain.pem \
#         --reloadcmd "sudo systemctl reload nginx.service"

# # ECC/ECDSA
# acme.sh --install-cert -d example.com --ecc \
#         --cert-file /etc/letsencrypt/example.com_ecc/cert.pem \
#         --key-file /etc/letsencrypt/example.com_ecc/private.key \
#         --fullchain-file /etc/letsencrypt/example.com_ecc/fullchain.pem \
#         --reloadcmd "sudo systemctl reload nginx.service"

#setup nginx
yum install -y nginx
systemctl start nginx.service
systemctl enable nginx.service

touch /etc/nginx/conf.d/pyro.conf && \
cat <<EOT >>  /etc/nginx/conf.d/pyro.conf
server {
  listen 80;
#   listen 443 ssl;
  server_name example.com;
  index index.php index.html;
  root /var/www/pyro/public;

#   ssl_certificate /etc/letsencrypt/status.example.com/fullchain.cer;
#   ssl_certificate_key /etc/letsencrypt/status.example.com/status.example.com.key;
#   ssl_certificate /etc/letsencrypt/status.example.com_ecc/fullchain.cer;
#   ssl_certificate_key /etc/letsencrypt/status.example.com_ecc/status.example.com.key;
  
  location / {
    try_files $uri $uri/ /index.php?$args;
  }

  location ~ \.php$ {
    include fastcgi_params;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_index index.php;
  }
}
EOT

systemctl reload nginx.service

#install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

php composer-setup.php

php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer
cp /usr/local/bin/composer /bin/composer
