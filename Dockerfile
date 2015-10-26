FROM ubuntu:trusty
ADD docker_files/install_jvm.sh /weblogic/install_jvm.sh
ADD docker_files/build_image.sh /weblogic/build_image.sh
ADD docker_files/entrypoint.sh /weblogic/entrypoint.sh
ADD docker_files/myDomain.py /weblogic/myDomain.py

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8
ENV MW_HOME=/weblogic/wls12130

VOLUME /weblogic/domains/mydomain

RUN apt-get update && \
    /weblogic/install_jvm.sh && \
    /weblogic/build_image.sh && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*
    

ENTRYPOINT /weblogic/entrypoint.sh
