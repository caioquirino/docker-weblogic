#!/bin/bash
set -e

# if command starts with an option, prepend mysqld
if [ "$#" -ne 1 ]; then
	shift; #remove first argument - own entrypoint file
	`$0`
	exit $?
fi

DOMAIN_NAME=mydomain
DOMAIN_DIR=/weblogic/domains/$DOMAIN_NAME
MW_HOME=/weblogic/wls12130

if [ -d $DOMAIN_DIR ]; then
  echo "Configuring weblogic..."
  $MW_HOME/configure.sh -silent
  $MW_HOME/wlserver/server/bin/setWLSEnv.sh

  echo "Creating domain..."
  mkdir -p $DOMAIN_DIR
  $MW_HOME/wlserver/common/bin/wlst.sh /weblogic/myDomain.py
fi

$MW_HOME/wlserver/server/bin/setWLSEnv.sh

$DOMAIN/startWebLogic.sh
