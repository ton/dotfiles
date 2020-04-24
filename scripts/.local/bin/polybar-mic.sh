#!/bin/sh

# Toggle mute status
if [ "$1" = "toggle" ]
then
    pactl set-source-mute 1 toggle
fi

status=$(pamixer --source 1 --get-mute)

# See: https://cdn.materialdesignicons.com/5.1.45/
if [ "$status" = "true" ];
then
    echo -e '\U0f036d'
else
    echo -e '\U0f036c'
fi
