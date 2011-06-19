# Remap caps lock to control.
setxkbmap -option ctrl:nocaps

# Start Dropbox applet.
if [ -f /usr/bin/dropbox ]
then
    /usr/bin/dropbox start &
fi

# Start Network Manager applet.
if [ -f /usr/bin/nm-applet ]
then
    /usr/bin/nm-applet &
fi

# exec subtle
exec wmfs
