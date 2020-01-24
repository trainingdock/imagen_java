FROM centos:7
MAINTAINER alberto
RUN yum install -y java wget mvn --setopt=tsflags=nodocs && \
    yum -y clean all
LABEL io.k8s.description="Platform for building and running Java8 apps" \
      io.k8s.display-name="Java8" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java8" \
      io.openshift.s2i.destination="/opt/app" \
      io.openshift.s2i.scripts-url=image:///tmpc/src
RUN adduser --system -u 1001 javauser
RUN mkdir -p /opt/app && chown -R javauser: /opt/app
RUN mkdir /tmp/src
COPY ./s2i/bin/ /tmp/src
RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src
USER 1001
EXPOSE 8080


