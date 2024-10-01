# NGINX image
FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

RUN mkdir -p /etc/nginx/ssl /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=IDF/L=Paris/O=42Paris/OU=rraffi-k/CN=rraffi-k.42.fr" \
	-keyout /etc/nginx/ssl/rraffi-k.42.fr.key \
	-out /etc/nginx/ssl/rraffi-k.42.fr.crt

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]