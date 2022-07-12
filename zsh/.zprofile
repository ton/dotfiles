# Unfortunately, we need to set PATH both in .zprofile and .zshrc under Arch,
# since the system wide zsh configuration resets PATH.
path=($HOME/.local/bin $path)

fortune -a
echo

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]];
then
    exec startx | tee $HOME/.local/share/xorg/startx.log
fi
