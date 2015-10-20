#!/bin/bash
function install_weblogic {
  echo "Unpacking weblogic..."
  apt-get install -y unzip
  cd /weblogic/
  unzip wls1213_dev_update3.zip
  rm -f wls1213_dev_update3.zip
}
install_weblogic
