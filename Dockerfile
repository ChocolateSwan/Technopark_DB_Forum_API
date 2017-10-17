
FROM ubuntu:16.04

MAINTAINER Surikova Olga

# Обвновление списка пакетов
RUN apt-get -y update

#
# Установка postgresql
#
ENV PGVER 9.5
RUN apt-get install -y postgresql-$PGVER

# Установка Python2
RUN apt-get install -y python2.7
RUN apt-get install -y python-pip
RUN pip2 install --upgrade pip
RUN pip2 install psycopg2
RUN pip2 install django
RUN pip2 install gunicorn




USER postgres

# Create a PostgreSQL role named ``olyasur`` with ``Arielariel111`` as the password and
# then create a database `dbapi` owned by the ``docker`` role.
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER olyasur WITH SUPERUSER PASSWORD 'Arielariel111';" &&\
    createdb -E UTF8 -T template0 -O olyasur ForumTP &&\
    /etc/init.d/postgresql stop

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$PGVER/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/$PGVER/main/postgresql.conf
RUN echo "synchronous_commit=off" >> /etc/postgresql/$PGVER/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Back to the root user
USER root

# Копируем исходный код в Docker-контейнер
ENV WORK /opt/TP
ADD ./DB_TP_ForumApp/ $WORK/DB_TP_ForumApp/
ADD dataBase.sql $WORK/dataBase.sql

# Объявлем порт сервера
EXPOSE 5000

#
# Запускаем PostgreSQL и сервер
#
ENV PGPASSWORD Arielariel111
CMD service postgresql start &&\
	psql -h localhost -U olyasur -d ForumTP -f $WORK/dataBase.sql &&\
	cd $WORK/DB_TP_ForumApp/ &&\
#	python manage.py runserver
	gunicorn -b :5000 DB_TP_ForumApp.wsgi
