FROM debian:jessie
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN apt-get update
RUN apt-get install -y chromium chromium-l10n chromedriver
RUN apt-get install -y xvfb
RUN apt-get install -y x11vnc
RUN apt-get install -y supervisor
RUN apt-get autoremove
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# workaround for missing runtime for chromium
RUN apt-get install -y libexif12

CMD ["/usr/bin/supervisord"]
