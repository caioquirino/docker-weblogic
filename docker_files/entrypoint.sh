#!/bin/bash
set -e

if [ "$#" -gt 0 ]; then
	$@
	exit $?
fi

if [ -z "$DOMAIN_DIR" ]; then
	DOMAIN_DIR=/weblogic/domains
	echo "DOMAIN_DIR environment variable not set. Using default: $DOMAIN_DIR"
	export DOMAIN_DIR
fi

if [ -z "$DOMAIN_NAME" ]; then
	DOMAIN_NAME=mydomain
	echo "DOMAIN_NAME environment variable not set. Using default: $DOMAIN_NAME"
	export DOMAIN_NAME
fi

$ORACLE_HOME/wlserver/server/bin/setWLSEnv.sh

if [ -d "$DOMAIN_DIR/$DOMAIN_NAME" ] ; then
  echo "Domain $DOMAIN_DIR/$DOMAIN_NAME already exists. Using it."
else
  echo "Creating domain..."

	if [ -z "$SERVER_START_MODE" ]; then
		SERVER_START_MODE="dev"
		echo "SERVER_START_MODE environment variable not set. Using default: $SERVER_START_MODE"
		export SERVER_START_MODE
	fi

	if [ -z "$WEBLOGIC_PASSWD" ]; then
		WEBLOGIC_PASSWD="weblogic123"
		echo "WEBLOGIC_PASSWD environment variable not set. Using default: $WEBLOGIC_PASSWD"
		export WEBLOGIC_PASSWD
	fi

  mkdir -p $DOMAIN_DIR/$DOMAIN_NAME
	set +e
  $ORACLE_HOME/wlserver/common/bin/wlst.sh /weblogic/myDomain.py
	if [ $? -ne 0 ]; then
		echo "Failed to create domain $DOMAIN_DIR/$DOMAIN_NAME."
		rm -rf $DOMAIN_DIR/$DOMAIN_NAME
		sleep infinity
		exit 1
	fi
	set -e
fi

unset WEBLOGIC_PASSWD

${DOMAIN_DIR}/${DOMAIN_NAME}/bin/setStartupEnv.sh
${DOMAIN_DIR}/${DOMAIN_NAME}/startWebLogic.sh || sleep infinity
