#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/../DroneConfig.cfg
if [[ $GCS_adress =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
 then
    ip=$GCS_adress
  else
  ip=`dig +short $GCS_adress`
fi
echo Ground Control IP adress: $ip
sudo $DIR/./udp_redirect 0.0.0.0 14550 $ip 14550 &
