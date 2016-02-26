FROM debian:jessie
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN apt-get update && apt-get install -y chromium chromium-l10n chromedriver ttf-japanese-mincho ttf-japanese-gothic
RUN apt-get install -y xvfb x11vnc
RUN apt-get install -y supervisor
RUN apt-get install -y libexif12 # workaround for missing runtime for chromium
RUN apt-get autoremove
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
