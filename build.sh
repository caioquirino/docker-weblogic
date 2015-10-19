#!/bin/bash
docker rm -f weblogic
docker build --rm -t weblogic .
