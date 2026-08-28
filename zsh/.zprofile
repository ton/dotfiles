# Unfortunately, we need to set PATH both in .zprofile and .zshrc under Arch,
# since the system wide zsh configuration resets PATH.
path=($HOME/.local/bin $path)

fortune -a
echo

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]];
then
    # In case Sway is available, default to Sway, otherwise start X11.
    if command -v sway; then
        # Generate a host specific Sway configuration.
        $HOME/.config/sway/host_specific_config.sh > $HOME/.config/sway/config

        # Generate a host specific Waybar configuration.
        $HOME/.config/waybar/host_specific_config.sh > $HOME/.config/waybar/config

        exec sway --unsupported-gpu
    else
        exec startx | tee $HOME/.local/share/xorg/startx.log
    fi
fi

if [ -f $HOME/.zprofile.local ];
then
    source $HOME/.zprofile.local
fi
