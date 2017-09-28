# Unfortunately, we need to set PATH both in .zprofile and .zshrc under Arch,
# since the system wide zsh configuration resets PATH.
path=($HOME/local/bin $HOME/.local/bin $path)

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]];
then
    exec startx
fi
