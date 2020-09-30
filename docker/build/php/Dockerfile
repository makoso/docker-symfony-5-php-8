FROM composer:2
FROM php:8.0-rc-fpm-alpine3.12

RUN set -xe && apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libzip-dev \
		icu-dev \
		postgresql-dev \
		zlib-dev \
		libpng-dev \
		openssh \
		sshpass \
		supervisor

RUN docker-php-ext-enable --ini-name 05-opcache.ini opcache
RUN runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"
RUN apk add --no-cache --virtual .php-phpexts-rundeps $runDeps
RUN apk del .build-deps

RUN apk add --update supervisor && rm  -rf /tmp/* /var/cache/apk/*

COPY --from=0 /usr/bin/composer /usr/bin/composer
COPY ./docker/build/php/php.ini /usr/local/etc/php/php.ini
COPY ./docker/build/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
COPY ./docker/build/php/supervisord.conf /etc/supervisord.conf

ENV COMPOSER_ALLOW_SUPERUSER 1

WORKDIR /var/www

COPY ./docker/build/php/supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

ENTRYPOINT ["docker-entrypoint"]
