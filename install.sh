#!/bin/sh
ln -sfr .dircolors $HOME/
ln -sfr .inputrc $HOME/
ln -sfr .gtkrc-2.0 $HOME/

ln -sfr .gitconfig $HOME/
ln -sfr .gitignore $HOME/

ln -sfr .i3 $HOME/
ln -sfr .i3blocks.conf $HOME/

ln -sfr .Xdefaults $HOME/
ln -sfr .xinitrc $HOME/

ln -sfr .zshrc $HOME/
ln -sfr .zshenv $HOME/
ln -sfr .zshenv.* $HOME/
ln -sfr .zsh $HOME/
ln -sfr .zprofile $HOME/

ln -sfr .tmux.conf $HOME/
ln -sfr .tmux.make.conf $HOME/

ln -sfr ccache.conf $HOME/

ln -sfr .config/compton.$(hostname).conf $HOME/.config/
ln -sfr .config/fontconfig $HOME/.config/
ln -sfr .config/cmus $HOME/.config/
ln -sfr .config/nvim $HOME/.config/

ln -sfr .local/bin/* $HOME/.local/bin/
