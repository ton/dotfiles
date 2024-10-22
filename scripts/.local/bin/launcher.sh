#!/usr/bin/env zsh
entries=$(whence -wm '*' | rg ': command' | sed 's/:[^:]*$//')

exec $(echo $entries | FZF_DEFAULT_OPTS="--reverse --no-separator --no-info --prompt='$ ' --margin=1,2 --height=6 --no-scrollbar" fzfmenu.sh -t '' -f "Source Code Pro:size=24:weight:medium")
