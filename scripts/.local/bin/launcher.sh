#!/bin/sh
entries="firefox st calculator.sh poweroff gimp snipit"

exec $(echo $entries | tr ' ' '\n' | FZF_DEFAULT_OPTS="--reverse --no-info --prompt='$ ' --margin=1,2 --height=4 --no-scrollbar" fzfmenu.sh -t '' -f "Source Code Pro:size=24:weight:medium")
