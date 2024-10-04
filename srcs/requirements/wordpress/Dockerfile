# Custom WordPress container image
FROM debian:bullseye

# Install packages for wordpress and php-fpm
RUN apt-get update && apt-get install -y \
	curl \
	mariadb-client \
	php \
	php-fpm \
	php-mysqli \
	php-gd \
	php-curl \
	php-zip \
	php-xml \
	php-mbstring \
	php-json \
	php-intl \
	php-dom \
	php-phar && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# !!! ATTENTION. Exact location for PHP config files based on its version !!!
# In `php-fpm.conf` line 17 and the very last line must contain the correct paths !
COPY ./tools/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY ./tools/www.conf  /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/config_wordpress.sh /tmp/

# EXPOSE 9000

ENTRYPOINT ["sh", "/tmp/config_wordpress.sh"]
