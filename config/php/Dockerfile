FROM php:8.1-fpm-bullseye

RUN pecl install xdebug-3.2.2 && \
    docker-php-ext-enable xdebug

RUN apt-get update && \
    apt-get install libonig-dev

RUN docker-php-ext-install pdo_mysql mysqli

EXPOSE 80
