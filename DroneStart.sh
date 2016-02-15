#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/./DroneConfig.cfg
source $DIR/script/DroneCode.sh
#Add 15sec checktime to cron.
	if [ $DroneCheck == "Yes" ]; then
		#write out current crontab
		crontab -l > $DIR/mycron
		#echo new cron into cron file
		echo "* * * * * /home/pi/UAVcast/script/./DroneCheck.sh > /home/pi/UAVcast/log/cron.log 2>&1"  >> mycron
		echo "* * * * * sleep 15; /home/pi/UAVcast/script/./DroneCheck.sh >> /home/pi/UAVcast/log/cron.log 2>&1"  >> mycron
		echo "* * * * * sleep 30; /home/pi/UAVcast/script/./DroneCheck.sh >> /home/pi/UAVcast/log/cron.log 2>&1"  >> mycron
		echo "* * * * * sleep 45; /home/pi/UAVcast/script/./DroneCheck.sh >> /home/pi/UAVcast/log/cron.log 2>&1"  >> mycron
		#install new cron file
		crontab mycron
		rm mycron
	else
	    crontab -r
fi

#Start DroneInit
DroneInit