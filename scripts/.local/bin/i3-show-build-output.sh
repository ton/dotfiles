#!/bin/sh

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $(basename "$0") <build log>"
    exit 1
fi

# Close all other build output windows that might still linger in the
# scratchpad.
i3-msg '[class="build_output"] kill' > /dev/null

sync_pipe_dir=$(mktemp -d)
trap 'rm -rf $sync_pipe_dir' INT EXIT

sync_pipe="$sync_pipe_dir/p"
mkfifo "$sync_pipe"

# Start a tmux session in a new terminal that shows the tail of the build
# output window. Write data to the FIFO from within the tmux session. Setting
# the tmux session up takes some time, we use the pipe for synchronization, so
# that when this script exits, we know for sure the build output window is
# visible.
build_log=$1
i3-sensible-terminal -c build_output -e tmux -f ~/.tmux.make.conf -L make new-session "trap 'rm $build_log' INT && echo '1' > $sync_pipe && tail -f $build_log" &

# Wait for data on pipe, then exit.
cat <"$sync_pipe" > /dev/null
