#!/bin/sh
focused_window=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5)
if ! xprop -id $focused_window | grep _NET_WM_STATE_FULLSCREEN > /dev/null;
then
    slock
else
    xset s reset
    xset dpms force on
fi
