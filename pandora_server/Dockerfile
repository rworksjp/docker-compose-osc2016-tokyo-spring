FROM centos:6
MAINTAINER Akihiro Uchida <auchida@rworks.jp>

RUN yum install -y epel-release \
 && yum clean all
RUN yum install -y supervisor \
 && yum clean all
ADD pandorafms.repo /etc/yum.repos.d/pandorafms.repo
RUN yum makecache \
 && yum install -y pandorafms_server \
 && yum clean all
RUN yum install -y \
    nagios-plugins-http \
    java-1.8.0-openjdk-headless \
 && yum clean all

RUN mkdir -p /opt/selenese \
 && curl -L -o /opt/selenese/selenese-runner.jar \
    https://github.com/vmi/selenese-runner-java/releases/download/selenese-runner-java-2.4.0/selenese-runner.jar
ADD selenese-runner /opt/selenese/selenese-runner
ADD testcase /opt/testcase

ADD register.pl /

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

ADD supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
