#!/bin/sh

mkdir -p "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.local/repos"

./clone-non-aur-tools.sh
./setup-aur.sh
./install-packages.sh
./stow-dotfiles.sh
