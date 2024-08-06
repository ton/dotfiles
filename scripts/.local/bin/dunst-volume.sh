#!/bin/sh
set -eu

if [ $1 == "up" ];
then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
else
    pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | sed 's/.* \([0-9]\+\)%.*/\1/g')

if [ $volume -eq 0 ]; then
    icon=''
elif [ $volume -lt 33 ]; then
    icon=''
elif [ $volume -lt 66 ]; then
    icon=''
else
    icon=''
fi

notify-send -t 1600 -h string:x-dunst-stack-tag:progress -u normal -h int:value:"$volume" "${icon} ${volume}%"
