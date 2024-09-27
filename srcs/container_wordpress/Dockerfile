FROM debian:11

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

COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./setup.sh /tmp

RUN chmod +x /tmp/setup.sh

# EXPOSE 9000

ENTRYPOINT ["/tmp/setup.sh"]



# FROM debian:11

# RUN apt-get -y update \
#     && apt install -y php-fpm php-mysql wget unzip \
#     && wget https://wordpress.org/latest.zip \
#     && unzip latest.zip \
#     && mkdir -p /run/php \
#     && mkdir -p /var/www/html \
#     && mv wordpress/* /var/www/html/ \
#     && chown -R www-data:www-data /var/www/html \
#     && rm latest.zip

# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf
# # COPY ./wp_config /var/www/html/wp_config


# EXPOSE 9000


# CMD ["php-fpm7.4", "-F"]

# # CMD ["wordpress"]