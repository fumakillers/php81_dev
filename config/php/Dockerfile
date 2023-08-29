FROM php:8.2-fpm-bullseye

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

RUN apt-get update && \
    apt-get install libonig-dev

RUN docker-php-ext-install pdo_mysql mysqli

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
