#!/bin/bash
set -e

sleep infinity

. $MW_HOME/wlserver/server/bin/setWLSEnv.sh

/weblogic/domains/mydomain/startWebLogic.sh
# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	$0
fi
