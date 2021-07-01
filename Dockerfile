
# DEBIAN BUSTER OS
FROM debian:buster

# UPDATE SOFTWARE
RUN apt-get update && apt-get -y upgrade

# WGET INSTALL
RUN apt-get -y install wget
RUN apt-get -y install vim

# INSTALL NGINX
RUN apt-get -y install nginx

# INSTALL SQL (mariadb)
RUN apt-get -y install mariadb-server

# INSTALL PHP PACKAGES
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-curl php7.3-gmp php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap

# COPY FILES
COPY ./srcs/starting_server.sh ./
COPY ./srcs/. ./tmp/

# CREATE FOLDER
RUN mkdir /etc/nginx/ssl

# DELETE DEFINE SETTINGS
RUN rm -rf /etc/nginx/sites-enabled/default

# GET KEYS FOR SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx-selfsigned.key \
    -out /etc/nginx/ssl/nginx-selfsigned.crt \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=21/OU=school/CN=localhost"

# START SERVER
CMD bash starting_server.sh
