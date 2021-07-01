
# START SQL
service mysql start

# ADD PERMISSIONS
chown -R www-data /var/www/*
chmod -R 755 var/www/*

# SKIP PASSWORD SQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES" | mysql -u root --skip-password

# CREATE FOLDERS
mkdir /var/www/localhost
mkdir /var/www/localhost/phpmyadmin

# MOVE FILES
mv ./tmp/nginx.conf /etc/nginx/sites-available/localhost

# CREATE LINK
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

# OPEN WORDPRESS
tar -xf /tmp/wordpress-5.4.2.tar.gz -C /var/www/localhost
mv ./tmp/index.html /var/www/localhost
mv ./tmp/wp-config.php var/www/localhost/wordpress

# # OPEN PHPMYADMIN
tar -xf /tmp/phpMyAdmin-5.0.2-english.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
cp ./tmp/config.inc.php /var/www/localhost/phpmyadmin

# START PHP
service php7.3-fpm start

# START NGINX
service nginx start

bash
