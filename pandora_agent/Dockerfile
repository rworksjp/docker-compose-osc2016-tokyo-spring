FROM node:4.3-slim
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN apt-get update \
 && apt-get install -y supervisor \
 && apt-get clean
RUN echo "deb http://www.artica.es/debian/squeeze /" > /etc/apt/sources.list.d/pandorafms.list \
 && apt-get update \
 && apt-get install -y --force-yes pandorafms-agent-unix \
 && apt-get clean

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

COPY webapp /opt/webapp
WORKDIR /opt/webapp
RUN npm install

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
