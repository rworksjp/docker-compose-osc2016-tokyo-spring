FROM centos:6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN yum distribution-synchronization -y
RUN yum install -y epel-release
ADD pandorafms.repo /etc/yum.repos.d/pandorafms.repo
RUN yum makecache
RUN yum install -y pandorafms_server
RUN yum install -y nagios-plugins-http
RUN yum install -y java-1.8.0-openjdk-headless
RUN yum install -y supervisor
RUN yum clean all
ADD supervisord.conf /etc/supervisord.conf

RUN mkdir -p /opt/selenese
RUN curl -L -o /opt/selenese/selenese-runner.jar https://github.com/vmi/selenese-runner-java/releases/download/selenese-runner-java-2.4.0/selenese-runner.jar
ADD selenese-runner /opt/selenese/selenese-runner
RUN chmod +x /opt/selenese/selenese-runner
ADD testcase /opt/testcase

ADD register.pl /
RUN chmod +x /register.pl
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
