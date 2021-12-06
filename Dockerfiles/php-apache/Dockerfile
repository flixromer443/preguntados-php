# Puedo elegir la version de php que voy a instalar
FROM php:7.3-apache 
# Puedo elegir la las librerias
RUN docker-php-ext-install mysqli
MAINTAINER "prof.fabian.lopez@gmail.com "
LABEL description="MySQL-LAMP apache - mysql - php"

# FROM php:5-apache-jessie

# RUN docker-php-ext-install mysql
 RUN docker-php-ext-install pdo
 RUN docker-php-ext-install pdo_mysql
 RUN docker-php-ext-install mysqli
RUN docker-php-ext-install sockets

RUN echo "date.timezone = America/Argentina/Buenos_Aires" > /usr/local/etc/php/php.ini
RUN echo "zklib.output_compression = On" > /usr/local/etc/php/php.ini

