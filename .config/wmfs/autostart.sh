#!/bin/bash

# Pick a random wallpaper from Dropbox.
wallpapers=(~/Dropbox/Photos/Wallpapers/*)
display -window root ${wallpapers[$[$RANDOM % ${#wallpapers[@]}]]}

# Open four terminals on tag 2 and 3.
if [ `pidof urxvtd | wc -l` -lt 1 ]
then
    urxvtd -f -o -q
    wmfs -c tag 2
    urxvtc
    urxvtc
    urxvtc
    urxvtc
    wmfs -c tag 3
    urxvtc
    urxvtc
    urxvtc
    urxvtc
fi
