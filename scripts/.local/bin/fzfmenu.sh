#!/bin/sh
st -c 'Floating' -g 40x4 "$@" sh -c "fzf < /proc/$$/fd/0 > /proc/$$/fd/1"
