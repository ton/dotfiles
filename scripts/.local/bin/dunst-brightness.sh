#!/bin/sh
set -eu

first_brightness_icon_code_point=0xf1a4e

if [ $1 == "up" ];
then
    light -A 5
else
    light -U 5
fi

brightness=$(light | grep -oE '^[0-9]+')
offset=$(($brightness / 11))
icon_code_point=$((first_brightness_icon_code_point + offset - 1))

printf -v icon "\U$(printf %x $icon_code_point)"

notify-send -t 1600 -h string:x-dunst-stack-tag:brightness -u normal -h int:value:"$brightness" "${icon} ${brightness}%"
