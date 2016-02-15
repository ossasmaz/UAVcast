#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/../DroneConfig.cfg
if [[ $GCS_adress =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
 then
    ip=$GCS_adress
  else
  ip=`dig +short $GCS_adress`
fi
echo $GCS_adress
echo APM starting:: stream adress: $ip
sudo $APM_type -A udp:$ip:14550
