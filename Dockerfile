FROM openshift/base-centos7
MAINTAINER akatbo@gmail.com

ENV JAVA_VERSON 1.8.0

RUN yum update -y && \
    yum install -y java-$JAVA_VERSON-openjdk java-$JAVA_VERSON-openjdk-devel && \
    yum clean all

ENV JAVA_HOME /usr/lib/jvm/java

LABEL io.k8s.description="Platform for building and running Java8 applications" \
      io.k8s.display-name="Java8" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java8" \
      io.openshift.s2i.destination="/opt/app" \
      io.openshift.s2i.scripts-url=image:///usr/local/s2i

RUN mkdir -p /opt/app

RUN adduser --system --base-dir /opt/app -u 10001 javauser && chown -R javauser: /opt/app

COPY ./S2iScripts/ /usr/local/s2i

USER 10001

EXPOSE 8080

CMD ["/usr/local/s2i/usage"]