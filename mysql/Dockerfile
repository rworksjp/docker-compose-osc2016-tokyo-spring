FROM mysql:5.6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN sed -i 's/^sql_mode=.*/sql_mode=NO_ENGINE_SUBSTITUTION/' /etc/mysql/my.cnf

CMD ["mysqld"]
