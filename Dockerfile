FROM ubuntu:trusty
ADD wls1213_dev_update3.zip /weblogic/wls1213_dev_update3.zip
ADD docker_files/install_jvm.sh /weblogic/install_jvm.sh
ADD docker_files/build_image.sh /weblogic/build_image.sh
ADD docker_files/entrypoint.sh /weblogic/entrypoint.sh
ADD docker_files/myDomain.py /weblogic/myDomain.py

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_40
ENV MW_HOME=/weblogic/wls12130

VOLUME /weblogic/domains/mydomain

RUN apt-get update
RUN /weblogic/install_jvm.sh
RUN /weblogic/build_image.sh

ENTRYPOINT /weblogic/entrypoint.sh
