#!/bin/bash
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

apt-get install -y -q wget
wget --no-cookies --progress=bar:force --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jdk-8u40-linux-x64.tar.gz" -P /tmp
mkdir /usr/lib/jvm
tar -xzf /tmp/jdk-8u40-linux-x64.tar.gz -C /usr/lib/jvm
rm -rf /tmp/jdk-8u40-linux-x64.tar.gz
ln -s /usr/lib/jvm/jdk1.8.0_40 /usr/lib/jvm/jdk1.8

update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8/bin/java 100
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8/bin/javac 100
update-alternatives --set java /usr/lib/jvm/jdk1.8/bin/java
update-alternatives --set javac /usr/lib/jvm/jdk1.8/bin/javac

export JAVA_HOME=/usr/lib/jvm/jdk1.8
export PATH=$PATH:$JAVA_HOME/bin
echo 'JAVA_HOME="/usr/lib/jvm/jdk1.8"' >> /etc/environment
source /etc/environment
