FROM centos:6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN yum distribution-synchronization -y
RUN yum install -y epel-release
ADD pandorafms.repo /etc/yum.repos.d/pandorafms.repo
RUN yum makecache && yum install -y pandorafms_console vlgothic-fonts && ln -s /usr/share/fonts/vlgothic/VL-Gothic-Regular.ttf /var/www/html/pandora_console/include/fonts/
RUN yum install -y mysql
RUN yum clean all

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
