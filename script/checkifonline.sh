#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/../DroneConfig.cfg
pidof -x runCode.sh >/dev/null
	if [[ $? -ne 0 ]] ; then 		
	LOCKFILE=/tmp/lock.txt
			if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
				echo "already running"
				exit
			fi

			# make sure the lockfile is removed when we exit and then claim it
			trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
			echo $$ > ${LOCKFILE}

			if wget -q --tries=10 --timeout=20 --spider http://google.com
				then
						sleep 1
						if wget -q --tries=10 --timeout=20 --spider http://google.com
						 then
							 sudo $DIR/./runCode.sh &
					
							else
									echo "RPI Online"
							fi
				else
					echo "RPI Online"
				fi

			rm -f ${LOCKFILE}
	else
		echo "CellDrone running."
		exit
	fi	
