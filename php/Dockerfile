ARG PHP_VERSION=8.0.3
FROM php:${PHP_VERSION}-apache

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions gd zip xdebug mysqli pdo_mysql opcache

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

RUN if [ ${PHP_SYMPHONY_CLI} = true ]; then \
    curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony\
;fi

COPY ./conf.d /usr/local/etc/php/conf.d

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf

RUN a2enmod rewrite

RUN chown -R www-data: /var/www/

VOLUME ["/var/log/apache2/logs/"]

ENV PHP_XDEBUG 1
ENV PHP_TIMEZONE "UTC+3"

# Show all apache configs
# RUN apache2ctl -S

USER www-data