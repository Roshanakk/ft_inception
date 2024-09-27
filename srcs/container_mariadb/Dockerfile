

FROM debian:latest

RUN apt-get -y update \
    && apt-get -y install mariadb-server mariadb-client

RUN mkdir -p /run/mysqld &&\
    chown -R mysql:mysql /run/mysqld && \
    mkdir -p /var/log/mysql

# EXPOSE 3306

COPY ./mariadb.sh .

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf
# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x ./mariadb.sh

# CMD ["bash", "./mariadb.sh"]

ENTRYPOINT ["bash", "./mariadb.sh"]
