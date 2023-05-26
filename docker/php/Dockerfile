FROM gitlab.marfa-tech.net:5050/backend/plumber/base:latest

MAINTAINER MarfaTech <https://marfa-tech.com>

WORKDIR /app
ARG COMPOSER_AUTH
ARG PHP_CS_FIXER_IGNORE_ENV

ENV COMPOSER_AUTH=${COMPOSER_AUTH}
ENV PHP_CS_FIXER_IGNORE_ENV=${PHP_CS_FIXER_IGNORE_ENV}

RUN git config --global --add safe.directory /app/vendor/marfatech/dto-resolver
RUN git config --global --add safe.directory /app/vendor/marfatech/api-platform-bundle
RUN git config --global --add safe.directory /app/vendor/marfatech/dbal-enum-type
RUN git config --global --add safe.directory /app/vendor/marfatech/dbal-enum-type-bundle
RUN git config --global --add safe.directory /app/vendor/marfatech/enumer
RUN git config --global --add safe.directory /app/vendor/marfatech/enumer-bundle

RUN mkdir -p var/log && mkdir -p var/cache && mkdir -p /tmp/${PROJECT_NAME} && mkdir -p tests/

RUN composer self-update --2

COPY . .
RUN mv docker/php/php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini
RUN mv docker/init-dotenv-local.sh /init-dotenv-local.sh

RUN composer install \
    --verbose \
    --optimize-autoloader \
    --no-interaction \
    --prefer-dist \
    --no-progress

CMD if [ "$xdebug" != "true" ]; then echo -e "\033[46m Xdebug is disabled \033[m" \
 && rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && php-fpm; else echo -e "\033[46m Xdebug is enabled \033[m" \
 && docker-php-ext-enable xdebug && php-fpm; fi

ENTRYPOINT ["/init-dotenv-local.sh"]