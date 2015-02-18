#!/bin/sh

# Remap caps lock to an additional control.
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Use ralt for composing special characters.
/usr/bin/setxkbmap -option "compose:ralt"

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

# Start compton for compositor effects.
compton --config ~/.config/compton.conf &

# Set the most recently configured wallpaper.
sh ~/.fehbg &

# Generate a host specific i3 configuration.
$HOME/.i3/host_specific_i3_config.sh > $HOME/.i3/config

# Start i3 session.
exec i3
