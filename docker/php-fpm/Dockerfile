FROM registry.marfa-tech.net/wakeapp/php:8.0.2-fpm as plumber-image

MAINTAINER MarfaTech <https://marfa-tech.com>

WORKDIR /app

ARG PROJECT_NAME
ARG APP_ENV
ARG DOMAIN
ARG APP_DEBUG
ARG API_RESPONSE_DEBUG
ARG MYSQL_BIREPORT_HOST
ARG MYSQL_BIREPORT_USER
ARG MYSQL_BIREPORT_PASSWORD
ARG MYSQL_BIREPORT_DATABASE
ARG GRAYLOG_HOST
ARG CLICKHOUSE_HOST
ARG CLICKHOUSE_USER
ARG CLICKHOUSE_PASSWORD
ARG CLICKHOUSE_DATABASE

RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    procps \
    gnupg \
    wget \
    libzip-dev && docker-php-ext-install zip intl

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "Europe/Moscow"\n' > /usr/local/etc/php/conf.d/tzone.ini

RUN mkdir -p var/log && mkdir -p var/cache && mkdir -p /tmp/${PROJECT_NAME} && mkdir -p tests/

RUN composer self-update --2

RUN echo "\n\
APP_ENV=${APP_ENV}\n\
DOMAIN=${DOMAIN}\n\
APP_DEBUG=${APP_DEBUG}\n\
MYSQL_BIREPORT_HOST=${MYSQL_BIREPORT_HOST}\n\
MYSQL_BIREPORT_USER=${MYSQL_BIREPORT_USER}\n\
MYSQL_BIREPORT_PASSWORD=${MYSQL_BIREPORT_PASSWORD}\n\
MYSQL_BIREPORT_DATABASE=${MYSQL_BIREPORT_DATABASE}\n\
DATABASE_BIREPORT_URL=//${MYSQL_BIREPORT_USER}:${MYSQL_BIREPORT_PASSWORD}@${MYSQL_BIREPORT_HOST}:3306/${MYSQL_BIREPORT_DATABASE}\n\
GRAYLOG_HOST=${GRAYLOG_HOST}\n\
CLICKHOUSE_HOST=${CLICKHOUSE_HOST}\n\
CLICKHOUSE_USER=${CLICKHOUSE_USER}\n\
CLICKHOUSE_PASSWORD=${CLICKHOUSE_PASSWORD}\n\
CLICKHOUSE_DATABASE=${CLICKHOUSE_DATABASE}\n\
" >> .env.local

COPY docker/php-fpm/php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini
COPY docker/php-fpm/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

COPY composer.json composer.json
COPY composer.lock composer.lock
COPY symfony.lock symfony.lock
COPY bin bin/
COPY config config/
COPY public public/
COPY .env .env
COPY src src/
COPY .php-cs-fixer.dist.php .php-cs-fixer.dist.php

RUN composer install \
    --verbose \
    --optimize-autoloader \
    --no-interaction \
    --prefer-dist \
    --no-progress

FROM plumber-image as plumber-image-sandbox

RUN composer install \
    --verbose \
    --optimize-autoloader \
    --no-interaction \
    --prefer-dist \
    --no-progress

RUN php bin/console cache:clear
RUN php bin/console cache:warmup
RUN php bin/console assets:install
