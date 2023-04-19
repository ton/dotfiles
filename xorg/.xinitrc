#!/bin/sh

# Set the correct GTK theme name (mainly for Qt based applications).
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Disable PC speaker.
xset -b

# Set keyboard repeat rate.
xset r rate 175 60

# Start Redshift.
if [ -f /usr/bin/redshift ]; then
    /usr/bin/redshift -l 51.431371:5.464261 -t 5500:2800 &
fi

# Start autocutsel allowing seamless copy/pasting between Vim and the terminal.
autocutsel -fork && autocutsel -selection PRIMARY -fork &

# Generate a host specific i3 configuration.
$HOME/.config/i3/host_specific_i3_config.sh > $HOME/.config/i3/config

# Disable the laptop display in case an external monitor is connected.
if [ -f $HOME/.local/bin/switch-to-monitor.sh ]; then
    $HOME/.local/bin/switch-to-monitor.sh
fi

# Set a wallpaper.
$HOME/.local/bin/update-wallpaper.sh

# Merge in X11 settings.
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

# Lock the screen after five minutes of inactivity, but only in case the
# currently focused window is not fullscreen.
xset s 600
xsidle.sh lock-if-not-fullscreen.sh &

# Set right alt as compose key.
setxkbmap -option compose:ralt

# Remap caps lock as control key.
setxkbmap -option caps:ctrl_modifier


# Start i3 session.
exec i3
