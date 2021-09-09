#!/bin/sh
blueman-applet &
while ! pgrep -x blueman-tray; do
    sleep 0.01
done
killall -e blueman-tray
