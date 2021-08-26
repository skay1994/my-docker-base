ARG PHP_VERSION=8.0-apache
FROM php:${PHP_VERSION}

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV PATH="/var/www/.composer/vendor/bin:$PATH"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions gd zip imap xdebug mysqli pdo_mysql opcache intl

ARG PHP_EXTENSIONS=''

RUN if [ ! -z "$PHP_EXTENSIONS" ]; then \
    install-php-extensions $PHP_EXTENSIONS\
;fi

RUN apt-get update; \ 
    apt-get install -y\
    zip \
    unzip \
    git

ARG PHP_SYMPHONY_CLI=false
ARG PHP_LARAVEL_CLI=false

RUN if [ ${PHP_SYMPHONY_CLI} = true ]; then \
    curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony\
;fi

RUN if [ ${PHP_LARAVEL_CLI} = true ]; then \
    composer global require laravel/installer \
;fi

COPY ./conf.d /usr/local/etc/php/conf.d

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf

RUN openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj \
    "/C=US" \
    -keyout /var/www/ssl.key -out /var/www/ssl.crt

RUN chown -R www-data: /var/www/

VOLUME ["/var/log/apache2/logs/"]

ENV PHP_XDEBUG 1
ENV PHP_TIMEZONE "UTC+3"

# Show all apache configs
# RUN apache2ctl -S

USER www-data