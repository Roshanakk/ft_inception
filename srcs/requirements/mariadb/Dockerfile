# Mariadb image
FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	mariadb-server \
	mariadb-client && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

COPY ./tools/config_mariadb.sh /tmp/
COPY ./tools/my.cnf /etc/mysql/my.cnf

ENTRYPOINT ["sh", "/tmp/config_mariadb.sh"]

# EXPOSE 3306

CMD ["mariadbd", "--user=mysql"]
