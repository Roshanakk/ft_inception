
#!/bin/bash

echo "..Running 'mariadb.sh' script.."

if [ ! -d "/var/lib/mysql/mysql" ]; then
	# creating necessary directories to install and run mariadb
	mkdir -p /var/lib/mysql /run/mysqld
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

	# Setting up mariadb configuration for network access
	sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
else
	echo "..mariadb already installed.."
fi


# Check if database already exists
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

	cat << EOF > /tmp/setup.sql
		USE mysql;
		FLUSH PRIVILEGES;
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
		CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
		CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
		GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
		FLUSH PRIVILEGES;
EOF
	# Starting mariadb in a bootstrap mode to create the database and user
	mariadbd --user=mysql --bootstrap --verbose=0 < /tmp/setup.sql
	rm -f /tmp/setup.sql

	echo "..database '${DB_NAME}' created.."
else
	echo "..database '${DB_NAME}' already exists.."
fi

exec "$@"

