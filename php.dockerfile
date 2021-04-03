FROM php:7.4-fpm-alpine

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html
RUN mkdir -p /var/www/html/xdebug

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

# xdebug
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug-3.0.3 \
    && docker-php-ext-enable xdebug \
    && apk del -f .build-deps

EXPOSE 9000
