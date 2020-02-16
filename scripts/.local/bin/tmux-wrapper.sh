#!/bin/sh
trap "tmux kill-session -t st-$$" INT TERM EXIT
tmux new-session -s st-$$ "$@"
exec "$SHELL"
