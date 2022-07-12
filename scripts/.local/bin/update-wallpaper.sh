#!/bin/sh

if [ $# -eq 0 ]; then
    wallpaper="$HOME/pictures/wallpaper"
else
    wallpaper="$1"
fi

hsetroot -root -fill "$wallpaper"
