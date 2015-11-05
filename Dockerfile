FROM frolvlad/alpine-oraclejdk8:slim

ADD docker_files/build_image.sh /weblogic/build_image.sh
ADD docker_files/entrypoint.sh /weblogic/entrypoint.sh
ADD docker_files/myDomain.py /weblogic/myDomain.py

ENV MW_HOME=/weblogic/wls12130

RUN apk add --update bash && \
    apk add --update wget && \
    /weblogic/build_image.sh && \
    rm -rf /var/lib/{cache,log}/ && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/*
    

ENTRYPOINT /weblogic/entrypoint.sh
