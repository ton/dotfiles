#!/bin/sh

# Remap caps lock to an additional control.
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Start urxvt shell daemon.
if ! `pidof -x urxvtd > /dev/null`
then
    urxvtd &
fi

# Set the correct GTK theme name (mainly for Qt based applications).
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Disable PC speaker.
xset -b
