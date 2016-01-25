FROM debian:jessie
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN apt-get update
RUN apt-get install -y chromium chromium-l10n chromedriver libexif12
RUN apt-get install -y xvfb
RUN apt-get install -y x11vnc
RUN apt-get install -y supervisor
RUN apt-get autoremove
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900
EXPOSE 9515

CMD ["/usr/bin/supervisord"]
