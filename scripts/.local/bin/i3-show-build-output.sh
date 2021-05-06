#!/bin/sh

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $(basename "$0") <build cmd> <log target>"
    exit 1
fi

build_cmd_line="$1"
build_cmd=$(echo "$build_cmd_line" | head -n 1 | cut -d " " -f1)
build_log="$2"

# Close all other build output windows that might still linger in the
# scratchpad.
i3-msg '[class="build_output"] kill' > /dev/null

# Create the build output file; `tail -f` will be executed prior to the build
# command.
touch build_log

# Start a tmux session in a new terminal that shows the tail of the build
# output window, for at most an hour (to be able to bring the build output back
# after the build finishes).
i3-sensible-terminal -c build_output -e tmux -f ~/.tmux.make.conf -L make new-session "trap 'killall $build_cmd' INT; tail -f $build_log && sleep 3600" &

# Start the build; append output to the build log that indicates the result of
# the build. Then, automatically hide the scratchpad output window.
($build_cmd_line && echo -e '\nBuild completed successfully 😊' || echo -e '\nBuild failed 😢') 2>&1 | tee "$build_log" \
    && i3-msg '[class="build_output"]' scratchpad show
