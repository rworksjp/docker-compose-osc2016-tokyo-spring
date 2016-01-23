FROM centos:6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN yum distribution-synchronization -y
RUN yum install -y epel-release
ADD pandorafms.repo /etc/yum.repos.d/pandorafms.repo
RUN yum makecache
RUN yum install -y perl pandorafms_agent_unix
RUN yum install -y supervisor
RUN yum clean all
ADD supervisord.conf /etc/supervisord.conf

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
