FROM centos:6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN yum distribution-synchronization -y
RUN yum install -y epel-release
ADD pandorafms.repo /etc/yum.repos.d/pandorafms.repo
RUN yum makecache
RUN yum install -y pandorafms_console
RUN yum install -y mysql
RUN yum clean all

EXPOSE 80

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
