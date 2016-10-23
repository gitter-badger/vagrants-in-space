#!/bin/bash

# Update package list and install software
apt-get install -y software-properties-common
add-apt-repository 'deb http://packages.dotdeb.org jessie all'
wget https://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg
apt-get update
apt-get install -y nginx php-fpm php-curl php7.0-apcu php7.0-gd php7.0-mbstring php7.0-mcrypt php7.0-xml php7.0-zip unzip zip

# Update Nginx config
cp /home/vagrant/config/default /etc/nginx/sites-available/default
systemctl restart nginx

# Download and install Grav
wget https://github.com/getgrav/grav/releases/download/1.1.8/grav-admin-v1.1.8.zip
unzip grav-admin-v1.1.8.zip
cp -a grav-admin/. /var/www/html
chown -R www-data:www-data /var/www/html
