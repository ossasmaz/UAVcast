#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/../DroneConfig.cfg
function usepicam {
raspivid  -n -w $WIDTH -h $HEIGHT -b $BITRATE -fps $FPS -t 0 -o - | \
    gst-launch-1.0 --gst-debug-level=0 -v \
    fdsrc !  \
    h264parse ! \
    rtph264pay config-interval=10 pt=96 ! \
    udpsink host=$GCS_adress port=$UDP_PORT
}

function C920 {
gst-launch-1.0 -v v4l2src device=/dev/video0 ! \
	video/x-h264,width=$WIDTH,height=$HEIGHT \
	,framerate=30/1 ! h264parse ! \
	 rtph264pay pt=127 config-interval=4 pt=96 ! \
	udpsink host=$GCS_adress port=$UDP_PORT
}
case "$CameraType" in
        "picam")
        usepicam
        ;;
        "C920")
        C920
        ;;
esac
