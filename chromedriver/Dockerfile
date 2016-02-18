FROM debian:jessie
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN echo "deb http://httpredir.debian.org/debian jessie contrib" > /etc/apt/sources.list.d/contrib.list
RUN apt-get update
RUN apt-get install -y chromium chromium-l10n chromedriver
RUN apt-get install -y xvfb
RUN apt-get install -y x11vnc
RUN apt-get install -y vnc-java
RUN apt-get install -y supervisor
RUN apt-get autoremove
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# workaround for missing runtime for chromium
RUN apt-get install -y libexif12

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
