#!/bin/sh

volume=$(pamixer --get-volume)
is_muted=$(pamixer --get-mute)

if [ $volume -eq 0 -o $is_muted == "true" ];
then
    # Unicode: f026 (volume-off)
    echo ""
elif [ $volume -lt 50 ];
then
    # Unicode: f027 (volume-down)
    echo " $volume%"
else
    # Unicode: f028 (volume-up)
    echo " $volume%"
fi
