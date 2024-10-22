#!/bin/sh
if command -v st > /dev/null ; then
    st -c 'Floating' -g 40x6 "$@" sh -c "fzf < /proc/$$/fd/0 > /proc/$$/fd/1"
elif command -v foot > /dev/null ; then
    foot -a 'Floating' -W 41x6 "$@" sh -c "fzf < /proc/$$/fd/0 > /proc/$$/fd/1"
fi
