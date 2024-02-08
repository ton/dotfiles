#!/bin/sh

stow \
    dunst \
    fontconfig \
    fonts \
    gdb \
    git \
    gnupg \
    gtk-2.0 \
    gtk-3.0 \
    i3 \
    mime \
    mpd \
    mplayer \
    ncmpcpp \
    nvim \
    polybar \
    scripts \
    shell \
    tmux \
    wallpapers \
    xdg \
    xorg \
    zsh

(cd "$HOME/.local/share/nvim" && mkdir -p backup undo swap)
