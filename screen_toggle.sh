#!/bin/sh

XRANDR_MSG=$(xrandr -q | egrep -o '[^s]+ connected')

SCREENMSG1=$(echo "${XRANDR_MSG}" | sed -n '1p')
SCREENMSG2=$(echo "${XRANDR_MSG}" | sed -n '2p')

SCREEN1=${SCREENMSG1% *}
SCREEN2=${SCREENMSG2% *}

TOGGLE=$HOME/.toggle_screen

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    xrandr --output $SCREEN1 --off
    
    sleep 1
    notify-send -u low --icon=/usr/share/icons/HighContrast/256x256/devices/computer.png "Screen disabled"
else
    rm $TOGGLE
    xrandr --output $SCREEN1 --auto
    xrandr --output $SCREEN2 --auto --right-of $SCREEN1
    
    sleep 1
    notify-send -u low --icon=/usr/share/icons/HighContrast/256x256/devices/computer.png "Screen enabled"
fi
