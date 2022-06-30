#!/bin/sh

AUR_DB="$HOME/.local/share/aur"
mkdir -p "$AUR_DB"

sed "s|AUR_DB|$AUR_DB|g" aur.conf | sudo tee /etc/aur.conf
echo "\nInclude = /etc/aur.conf" | sudo tee -a /etc/pacman.conf

sudo install -d "$AUR_DB" -o $USER
repo-add "$AUR_DB/custom.db.tar.gz"
