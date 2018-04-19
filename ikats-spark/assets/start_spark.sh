#!/bin/bash

# SPARK_MODE can be either "master" or "slave"
[[ -z ${SPARK_MODE} ]] && echo "SPARK_MODE must be defined ('master' or 'slave')" && exit;

if [[ ! -z ${SPARK_MASTER_HOST} ]]
then
  spark_addr="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"
fi

# Start the corresponding spark master/slave
${SPARK_HOME}/sbin/start-${SPARK_MODE}.sh $spark_addr

sleep infinity
