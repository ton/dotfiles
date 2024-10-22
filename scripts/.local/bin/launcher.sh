#!/usr/bin/env zsh
entries=$(whence -wm '*' | rg ': command' | sed 's/:[^:]*$//')

exec $(echo $entries | tr ' ' '\n' | FZF_DEFAULT_OPTS="--reverse --no-info --prompt='$ ' --margin=0,0 --padding=0,0,0,1 --height=4 --no-scrollbar" fzfmenu.sh -t '' -f "Source Code Pro:size=24:weight:medium")
