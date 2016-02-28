FROM debian:jessie
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN apt-get update \
 && apt-get install -y supervisor \
 && apt-get clean
# libexif12 is required for a workaround to resolve chromium missing runtime
RUN apt-get update \
 && apt-get install -y \
    chromium chromium-l10n chromedriver \
    ttf-japanese-mincho ttf-japanese-gothic \
    libexif12 \
 && apt-get clean
RUN apt-get update && apt-get install -y \
    xvfb x11vnc \
 && apt-get clean

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
