#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/../DroneConfig.cfg
source $DIR/./DroneCode.sh
pidof -x DroneCode.sh >/dev/null
	if [[ $? -ne 0 ]] ; then 		
    	if [ $DroneCheck == "Yes" ]; then
			LOCKFILE=/tmp/lock.txt
					if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
						exit
					fi
					# make sure the lockfile is removed when we exit and then claim it
					trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
					echo $$ > ${LOCKFILE}
					wget -q --tries=10 --timeout=20 --spider http://google.com
					if [[ $? -ne 0 ]]; then
								sleep 1
								wget -q --tries=10 --timeout=20 --spider http://google.com
								if [[ $? -ne 0 ]]; then
									 echo "RPI is offline, run DroneCode"
									 case $GSM_Connect in
										"uqmi")
											pidof -x $GSM_Connect >/dev/null
											if [[ $? -ne 0 ]] ; then 	
													echo "Trying to start UQMI"
													uqmi
											 fi
											;;
											"wvdial")	
													wvdial
											;;
									esac
								else
									echo "RPI Online"
							fi
						else
							echo "RPI Online"
						fi

					rm -f ${LOCKFILE}
					
		fi			
	else
		echo "DroneCode running."
		exit
	fi	
