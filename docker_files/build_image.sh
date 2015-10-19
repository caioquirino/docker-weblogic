#!/bin/bash

function install_weblogic {

  echo "Unpacking weblogic..."
  apt-get install -y unzip
  unzip wls1213_dev_update3.zip
  cd wls12130
  export MW_HOME=/weblogic/wls12130

  echo "Configuring weblogic..."
  . ./configure.sh -silent
  . $MW_HOME/wlserver/server/bin/setWLSEnv.sh


  echo "Creating domain..."
  mkdir -p /weblogic/domains/mydomain
  #java weblogic.WLST myDomain.py
  $MW_HOME/wlserver/common/bin/wlst.sh /weblogic/myDomain.py
  cd /weblogic/domains/mydomain
  ls
}


function clean {
  rm -rf wls12130
}
install_weblogic
clean
