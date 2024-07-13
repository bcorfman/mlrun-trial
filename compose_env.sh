#!/bin/bash
HOST_IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
echo HOST_IP="$HOST_IP" > .env
echo MLRUN_DBPATH=http://"$HOST_IP":8080 >> .env
SHARED_DIR=~/mlrun-data
echo SHARED_DIR="$SHARED_DIR" >> .env
mkdir -p $SHARED_DIR
