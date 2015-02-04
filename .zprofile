# Unfortunately, we need to set PATH in .zshrc under Arch.
path=($HOME/local/bin $path)

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]];
then
    exec startx
fi
