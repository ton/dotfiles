#!/bin/sh

# Toggle mute status
if [ "$1" = "toggle" ]
then
    pactl set-source-mute 1 toggle
fi

status=$(pamixer --source 1 --get-mute)

if [ "$status" = "true" ];
then
    echo 
else
    echo 
fi
