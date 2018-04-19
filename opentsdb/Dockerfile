FROM cloudflare/opentsdb:2.3.0

MAINTAINER Germain GAU <germain.gau@c-s.fr>

RUN mkdir /logs && chmod -R 777 /logs

ADD logback.xml /usr/share/opentsdb/logback.xml

COPY container_init.sh /container_init.sh
RUN chmod +x /container_init.sh

ENTRYPOINT /container_init.sh
