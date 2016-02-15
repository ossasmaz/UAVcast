#!/bin/bash
 
# Create a log file of the build as well as displaying the build on the tty as it runs
exec > >(tee build_UAV.log)
exec 2>&1
 
################# COMPILE UAV software ############
 
 
# Update and Upgrade the Pi, otherwise the build may fail due to inconsistencies
 
sudo apt-get update && sudo apt-get upgrade -y --force-yes

# Get the required libraries
sudo apt-get install -y --force-yes build-essential dnsutils inadyn usb-modeswitch \
                                    cmake dh-autoreconf wvdial gstreamer1.0
                                    
cd /home/pi
        git clone https://github.com/UAVmatrix/UAVcast.git
mkdir packages
cd packages

	git clone https://github.com/UAVmatrix/libubox.git libubox
	git clone git://nbd.name/uqmi.git


wget  https://s3.amazonaws.com/json-c_releases/releases/json-c-0.12.tar.gz
tar -xvf json-c-0.12.tar.gz
cd json-c-0.12
sed -i s/-Werror// Makefile.in   && ./configure --prefix=/usr --disable-static  && make -j1
make install
cd ..


cd libubox
cmake CMakeLists.txt -DBUILD_LUA=OFF
make
sudo make install
mkdir -p /usr/include/libubox
cp *.h /usr/include/libubox
cp libubox.so /usr/lib
cp libblobmsg_json.so /usr/lib
cd ..

cd uqmi
sudo cmake CMakeLists.txt
sudo make install
