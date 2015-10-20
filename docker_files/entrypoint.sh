#!/bin/bash
set -e

# if command starts with an option, prepend mysqld
if [ "$#" -gt 0 ]; then
	echo $0
	shift; #remove first argument - own entrypoint file
	`$0`
	exit $?
fi

DOMAIN_NAME=mydomain
DOMAIN_DIR=/weblogic/domains/$DOMAIN_NAME
MW_HOME=/weblogic/wls12130

$MW_HOME/wlserver/server/bin/setWLSEnv.sh

if [ -d $DOMAIN_DIR ]; then
  echo "Creating domain..."
  mkdir -p $DOMAIN_DIR
  $MW_HOME/wlserver/common/bin/wlst.sh /weblogic/myDomain.py
fi

$DOMAIN_DIR/startWebLogic.sh
