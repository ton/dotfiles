#!/bin/sh

LAPTOP_DISPLAY="eDP-1"
xrandr -d :0 --output ${LAPTOP_DISPLAY} --auto

# Rescale background image.
sh /home/ton/.fehbg &

logger "Using laptop display as primary output."
