

FROM debian:bullseye

RUN apt-get -y update \
    && apt-get -y install \
    mariadb-server \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld
    && chown -R mysql:mysql /run/mysqld

# EXPOSE 3306

COPY ./tools/mariadb.sh /tmp/

COPY ./tools/mariadb-server.cnf /etc/mysql/mariadb-server.cnf

# CMD ["bash", "./mariadb.sh"]

ENTRYPOINT ["bash", "./mariadb.sh"]

CMD ["mariadbd", "--user=mysql"]