#!/bin/bash

# Encapsulate offical entrypoint into our to start our own scripts

# Refresh /etc/hosts every REFRESH_HOSTS_PERIOD seconds
REFRESH_HOSTS_PERIOD=${REFRESH_HOSTS_PERIOD:-10}
refresh_hosts(){
  # Update only if configMap is available
  [ -e /etc/hbase/hosts ] && cat /etc/hbase/hosts > /etc/hosts
  while true
  do
    [ -e /etc/hbase/hosts ] && cat /etc/hbase/hosts > /etc/hosts;
    sleep ${REFRESH_HOSTS_PERIOD}
  done
}

# Start the refresh script
refresh_hosts &

# Call the original cloudflare/opentsdb entrypoint
/run.sh
