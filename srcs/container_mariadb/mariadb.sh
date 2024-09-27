
#!/bin/bash
set -eux

if [ ! -d "/var/lib/mysql/mysql" ]; then
	# creating necessary directories to install and run mariadb
	mkdir -p /var/lib/mysql /run/mysqld
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

	# Setting up mariadb configuration for network access
	sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

	# echo "..Installing mariadb.."
	# mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db --skip-name-resolve --auth-root-authentication-method=normal
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
else
	echo "..mariadb already installed.."
fi


service mariadb start

# if [ -d /var/lib/mysql/wordpress_db ]; then
#     echo "database already exists '${MYSQL_DATABASE}'"
# else
#     mysql -h localhost -u root -p${DB_ROOT_PASSWORD} -e \
#         "FLUSH PRIVILEGES;
#         DELETE FROM mysql.user WHERE User='';
#         DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#         ALTER USER 'root'@'localhost' IDENTIFIED BY \`$DB_ROOT_PASSWORD\`;

#         CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;
#         CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '${DB_PASSWORD}';
#         GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$DB_USER'@'%';
#         FLUSH PRIVILEGES;"

# fi

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD');
EOF

sleep 5

service mariadb stop

exec /usr/sbin/mariadbd --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/log/mysql/error.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock

# exec mysqld_safe

