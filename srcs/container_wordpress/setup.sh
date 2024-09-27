#!/bin/bash

set -ux

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

if ! $(wp --allow-root --path="/var/www/html" core is-installed);
then

	addgroup -g 82 -s www-data 2>/dev/null
	adduser -u 82 -D -S -G www-data www-data 2>/dev/null

    curl -o /var/www/html/adminer.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php
	curl -o /var/www/html/adminer.css https://raw.githubusercontent.com/vrana/adminer/master/designs/hever/adminer.css
    
    mkdir -p /var/www/html
    cd /var/www/html

	# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	# chmod +x wp-cli.phar
	# mv wp-cli.phar /usr/local/bin/wp

    wp core download --allow-root --path=/var/www/html 

    wp config create --allow-root --path="/var/www/html" \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=${DB_HOST} \
        --path=/var/www/html/ \
        --skip-check

    wp core install --allow-root --path="/var/www/html" \
        --url=${WP_URL} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_LOGIN} \
        --admin_password=${WP_PASSWORD} \
        --admin_email=${WP_EMAIL} \
        --skip-email --path=/var/www/html/

    # wp user create $PUBLIC_USER $PUBLIC_EMAIL \
    #     --role=author \
    #     --allow-root \
    #     --user_pass=$PUBLIC_PASS
    
fi;

php-fpm7.4 -F



# #!/bin/bash

# set -ux

# # Move WordPress files to the correct location
# mkdir -p /var/www/html
# mv wordpress/* /var/www/html/

# # Set permissions
# chmod -R 755 /var/www/html
# chown -R www-data:www-data /var/www/html

# # Check if WP-CLI is installed
# if ! /usr/local/bin/wp --info > /dev/null 2>&1; then
#     echo "WP-CLI is not correctly installed."
#     exit 1
# fi

# # Wait for the database to be ready
# until wp db check --allow-root --path="/var/www/html"; do
#     echo "Waiting for the database to be ready..."
#     sleep 5
# done

# # Check if WordPress is already installed
# if ! wp --allow-root --path="/var/www/html" core is-installed; then
#     echo "WordPress is not installed. Proceeding with installation."

#     # Download WordPress core files
#     wp core download --path=/var/www/html --allow-root

#     # Create wp-config.php
#     wp config create --allow-root --path="/var/www/html" \
#         --dbname=$WORDPRESS_DB_NAME \
#         --dbuser=$WORDPRESS_DB_USER \
#         --dbpass=$WORDPRESS_DB_PASSWORD \
#         --dbhost=$WORDPRESS_DB_HOST \
#         --dbprefix=$WORDPRESS_DB_PREFIX \
#         --skip-check

#     # Install WordPress
#     wp core install --allow-root --path="/var/www/html" \
#         --url=$WP_URL \
#         --title=$WP_TITLE \
#         --admin_user=$WP_ADMIN_USER \
#         --admin_password=$WP_ADMIN_PASSWORD \
#         --admin_email=$WP_ADMIN_EMAIL

#     # Create a new user
#     wp user create $PUBLIC_USER $PUBLIC_EMAIL --role=author --allow-root \
#         --user_pass=$PUBLIC_PASS
# else
#     echo "WordPress is already installed."
# fi

# # Start PHP-FPM
# php-fpm7.4 -F