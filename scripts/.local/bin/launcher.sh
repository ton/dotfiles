#!/bin/sh
entries="firefox st calculator.sh"

export FZF_DEFAULT_OPTS="--reverse --no-info --prompt='$ ' --margin=1,2 --height=4 --no-scrollbar"

exec $(echo $entries | tr ' ' '\n' | fzfmenu.sh -t '' -f "Source Code Pro:size=24:weight:medium")
