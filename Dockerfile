FROM php:8.1-fpm

RUN pecl install xdebug-3.2.2 && \
    docker-php-ext-enable xdebug
