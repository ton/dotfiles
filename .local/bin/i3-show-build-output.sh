#!/bin/sh

# Close all other build output windows that might still linger in the
# scratchpad.
i3-msg '[instance="build_output"] kill' > /dev/null

exec alacritty --class build_output -d 0 0 -e tmux -f $HOME/.tmux.make.conf -L make new-session "trap 'rm $1' SIGINT ; tail -f $1"
