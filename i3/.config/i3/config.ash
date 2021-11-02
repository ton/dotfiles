# Start VirtualBox client features.
exec_always --no-startup-id VBoxClient-all

# Auto-stretch wallpaper.
exec_always --no-startup-id xeventbind resolution ~/.local/bin/update-wallpaper.sh &

# Start a terminal.
bindsym $mod+c exec --no-startup-id i3-smart-split.py "i3-sensible-terminal tmux"

# Mapping in case no multimedia keys are available.
bindsym $mod+m exec --no-startup-id pulseaudio-ctl mute
bindsym $mod+Up exec --no-startup-id pulseaudio-ctl up
bindsym $mod+Down exec --no-startup-id pulseaudio-ctl down
