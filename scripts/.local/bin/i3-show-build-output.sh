#!/bin/sh

# Close all other build output windows that might still linger in the
# scratchpad.
i3-msg '[class="build_output"] kill' > /dev/null

exec i3-sensible-terminal -c build_output -e tmux -f $HOME/.tmux.make.conf -L make new-session "trap 'rm $1' SIGINT ; tail -f $1"
