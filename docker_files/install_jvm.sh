#!/bin/bash
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

wget --no-cookies --progress=bar:force --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jdk-8u40-linux-x64.tar.gz" -P /tmp
mkdir /usr/lib/jvm
tar -xzf /tmp/jdk-8u40-linux-x64.tar.gz -C /usr/lib/jvm
rm -rf /tmp/jdk-8u40-linux-x64.tar.gz
ln -s /usr/lib/jvm/jdk1.8.0_40 /usr/lib/jvm/jdk1.8

ln -s /usr/lib/jvm/jdk1.8/bin/java /usr/bin/java
ln -s /usr/lib/jvm/jdk1.8/bin/javac /usr/bin/javac

export JAVA_HOME=/usr/lib/jvm/jdk1.8
export PATH=$PATH:$JAVA_HOME/bin
echo 'JAVA_HOME="/usr/lib/jvm/jdk1.8"' >> /etc/environment
source /etc/environment
