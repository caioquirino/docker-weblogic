#!/bin/bash
function install_weblogic {
  mkdir -p /weblogic/wls1221
  cd /weblogic/wls1221

  echo "Downloading weblogic..."
  wget --progress=bar:force --no-check-certificate \
    "https://www.dropbox.com/s/7ty1e1hug04lfyn/fmw_12.2.1.0.0_wls_quick_Disk1_1of1.zip?dl=0" \
    -O fmw_12.2.1.0.0_wls_quick_Disk1_1of1.zip

  echo "Unpacking weblogic..."
  unzip fmw_12.2.1.0.0_wls_quick_Disk1_1of1.zip
  rm -f fmw_12.2.1.0.0_wls_quick_Disk1_1of1.zip

  ORACLE_HOME="/weblogic/wls1221/oracle"
  adduser -D -g "" -h /home/weblogic -s /bin/bash weblogic
  mkdir -p $ORACLE_HOME
  chown -R weblogic $ORACLE_HOME
  rm -rf $ORACLE_HOME/*

  echo "Configuring weblogic..."
  su -p weblogic -c "cd /; java -jar /weblogic/wls1221/fmw_12.2.1.0.0_wls_quick.jar -ignoreSysPrereqs ORACLE_HOME=$ORACLE_HOME"
  rm -rf /home/weblogic/*
  rm -rf /tmp/*
}
install_weblogic
