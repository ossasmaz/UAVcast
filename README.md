# UAVcast

UAVcast uses regular software such as wvdial, inadyn. gstreamer, uqmi, and will fire up each program in the correct order users has defined in the DroneConfig.cfg file. 
 
After you have successfully installed UAVcast and edited DroneConfig, you could simply start UAVcast by running DroneStart.sh
If there is any problems during startup, then please check the logfile located in the /log category.
 
 
 
UAVcast Usage
nano /home/pi/UAVcast/DroneConfig.cfg
This file conatins the configuration parameters for UAVcast scripts. Simply set your desired options and save the file.
 

Run UAVcast/DroneStart.sh
sudo /home/pi/UAVcast/./DroneStart.sh
 

If you want to start the script automatically during bootup
nano /etc/rc.local
 

add these lines to rc.local
sleep 20 
sudo /home/pi/UAVcast/./DroneStart.sh
 

If you are using PiCam, remember to enable the camera in Raspi-Config
raspi-config
 
