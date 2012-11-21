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

# Start Redshift.
if [ -f /usr/bin/redshift ]
then
    /usr/bin/redshift -l 51.431371:5.464261 -t 5500:4200 &
fi

# Start Dropbox in case it is installed.
if [ -f $HOME/.dropbox-dist/dropboxd ]
then
    $HOME/.dropbox-dist/dropboxd &
fi

# Start autocutsel allowing seemless copy/pasting between Vim and the terminal.
autocutsel -selection PRIMARY -fork &

# Start XFCE4 session.
exec startxfce4
