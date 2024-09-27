FROM debian:11

RUN apt-get -y update && apt-get -y install nginx openssl \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/rraffi-k.42.fr.key \
        -out /etc/nginx/ssl/rraffi-k.42.fr.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rraffi-k.42.fr/UID=rraffi-k"

# COPY ./var/www/example/index.html ./var/index.html

# COPY ./ssl/rraffi-k.42.fr.crt /etc/nginx/ssl/rraffi-k.42.fr.crt
# COPY ./ssl/rraffi-k.42.fr.key /etc/nginx/ssl/rraffi-k.42.fr.key


COPY ./tools/nginx.conf /etc/nginx/nginx.conf

# EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]