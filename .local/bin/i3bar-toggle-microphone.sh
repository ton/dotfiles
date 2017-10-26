#!/bin/sh

# Toggle mute status
pactl set-source-mute 1 toggle

status=$(pamixer --source 1 --get-mute)

if [ $status == "true" ];
then
    echo ""
else
    echo ""
fi
