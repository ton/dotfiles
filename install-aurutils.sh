#!/bin/sh

AUR_DB="$HOME/.local/share/aur"
mkdir -p "$AUR_DB"

cd "$AUR_DB"
git clone https://aur.archlinux.org/aurutils.git aurutils

cd aurutils
makepkg -si
