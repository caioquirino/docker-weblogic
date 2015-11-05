FROM alpine:latest

ADD docker_files/install_jvm.sh /weblogic/install_jvm.sh
ADD docker_files/build_image.sh /weblogic/build_image.sh
ADD docker_files/entrypoint.sh /weblogic/entrypoint.sh
ADD docker_files/myDomain.py /weblogic/myDomain.py

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8
ENV MW_HOME=/weblogic/wls12130

RUN apk add --update bash && \
    apk add --update wget && \
    /weblogic/install_jvm.sh && \
    /weblogic/build_image.sh && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/*
    

ENTRYPOINT /weblogic/entrypoint.sh
