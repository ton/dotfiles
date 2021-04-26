#!/bin/sh

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $(basename "$0") <build cmd> <log target>"
    exit 1
fi

build_cmd="$1"
build_log="$2"

# Close all other build output windows that might still linger in the
# scratchpad.
i3-msg '[class="build_output"] kill' > /dev/null

# Start the build; append output to the build log that indicates the result of
# the build. Then, automatically hide the scratchpad output window, and let the
# window stick around for at most an hour before closing it, so that it can be
# referred back to after the build finishes.
build_output_cmd="
    ($build_cmd && echo -e '\nBuild completed successfully 😊' || echo -e '\nBuild failed 😢') 2>&1 | tee $build_log \
    && i3-msg '[class=\"build_output\"]' scratchpad show &> /dev/null \
    && sleep 3600"

# Start a tmux session in a new terminal that shows the tail of the build
# output window.
i3-sensible-terminal -c build_output -e tmux -f ~/.tmux.make.conf -L make new-session "$build_output_cmd" &
