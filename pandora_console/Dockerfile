FROM centos:6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN yum install -y epel-release \
 && yum clean all
ADD pandorafms.repo /etc/yum.repos.d/pandorafms.repo
RUN yum makecache \
 && yum install -y pandorafms_console \
 && yum clean all
RUN yum install -y vlgothic-fonts mysql \
 && yum clean all \
 && ln -s /usr/share/fonts/vlgothic/VL-Gothic-Regular.ttf /var/www/html/pandora_console/include/fonts/

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
