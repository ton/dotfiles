#!/bin/bash

# Determine microphone source number.
source=$(pamixer --list-sources | grep "$1" | head -c 1)

# Toggle mute status
if [ "$2" = "toggle" ]
then
    pactl set-source-mute $source toggle
fi

status=$(pamixer --source $source --get-mute)

# See: https://cdn.materialdesignicons.com/5.1.45/
if [ "$status" = "true" ];
then
    echo -e '\U0f036d'
else
    echo -e '\U0f036c'
fi
