#!/bin/bash

if [ "$(pidof banshee)" ]
then
    player="banshee"
    play_pause="--toggle-playing"
else
    if [ "$(pidof rhythmbox)" ]
    then
        player="rhythmbox-client"
        play_pause="--play-pause"
    fi
fi

mixer="Master Front"

for i in $*
do
    case $i in
        --play-pause)
            $player $play_pause
            ;;
        --next)
            $player --next
            ;;
        --previous)
            $player --previous
            ;;
        --mute-toggle)
            amixer set "$mixer" toggle
            ;;
        --status)
            amixer get "$mixer"
            ;;
        --volume-up)
            amixer set "$mixer" 1+ unmute
            ;;
        --volume-down)
            amixer set "$mixer" 1-
            ;;
        *)
            ;;
    esac
done
