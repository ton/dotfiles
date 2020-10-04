#!/bin/sh
stow \
    ccache \
    fehbg \
    fontconfig \
    gdb \
    git \
    gtk-2.0 \
    gtk-3.0 \
    i3 \
    mime \
    mpd \
    nvim \
    polybar \
    scripts \
    shell \
    tmux \
    xorg \
    zsh

sudo stow xorg.conf.d -t /etc/X11/xorg.conf.d
