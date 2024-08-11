#!/bin/sh
entries="firefox st calculator.sh poweroff reboot gimp snipit idea.sh blender freecad zeal inkscape transmission-gtk passmenu"

exec $(echo $entries | tr ' ' '\n' | FZF_DEFAULT_OPTS="--reverse --no-info --prompt='$ ' --margin=0,0 --padding=0,0,0,1 --height=4 --no-scrollbar" fzfmenu.sh -t '' -f "Source Code Pro:size=24:weight:medium")
