#!/bin/sh

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $(basename "$0") <build cmd> <log target>"
    exit 1
fi

build_cmd="$1"
build_log="$2"

# Remove ANSI escape sequences from the build output.
decolorize()
{
    sed -i 's/\x1b\[[0-9;]*[a-zA-Z]//g' "$build_log"
}

trap decolorize EXIT INT TERM

# Determine the process group ID of this script.
pgid=$(ps -o pgid= $$)

# Close all other build output windows that might still linger in the
# scratchpad.
i3-msg '[class="build_output"] kill' > /dev/null

# Create the build output file; `tail -f` will be executed prior to the build
# command.
touch "$build_log"

# Start a tmux session in a new terminal that shows the tail of the build
# output window, for at most an hour (to be able to bring the build output back
# after the build finishes).
i3-sensible-terminal -c build_output -e tmux -f ~/.tmux.make.conf -L make new-session "i3-tail-build-output.sh $build_log $pgid" &

# Wait for the build output window to show, such that hiding the build output
# later on will surely succeed.
i3-msg -t subscribe '[ "window" ]' -m | grep -q build_output

# Start the build; append output to the build log that indicates the result of
# the build. Then in case the build is successful automatically hide the
# scratchpad output window and decolorize the output for display in Neovim.
{ unbuffer "$build_cmd" && printf '\nBuild completed successfully 😊' || printf '\nBuild failed 😢'; } > "$build_log" 2>&1

# Hide the build output window.
i3-msg '[class="build_output"]' scratchpad show
