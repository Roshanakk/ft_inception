FROM debian:bullseye

RUN apt-get -y update && apt-get install -y \
    mariadb-client \
    php7.4-fpm \
    php7.4-mysql \
    wget \
    unzip \
    curl \
	php \
	php-gd \
	php-curl \
	php-zip \
	php-xml \
	php-mbstring \
	php-json \
	php-intl \
	php-dom \
	php-phar \
	&& mkdir -p /run/php

COPY ./tools/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/setup.sh /tmp

# EXPOSE 9000

ENTRYPOINT ["/tmp/setup.sh"]
