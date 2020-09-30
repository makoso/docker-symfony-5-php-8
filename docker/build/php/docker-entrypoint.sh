#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

if [ "$1" = 'php-fpm' ] || [ "$1" = 'bin/console' ]; then
    if [ "$APP_ENV" != 'prod' ]; then
      composer install --dev
    fi
		php bin/console cache:clear
		php bin/console cache:warmup
fi


exec docker-php-entrypoint "$@"
