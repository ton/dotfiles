# Make sure environment variables only contain unique entries.
typeset -U ld_library_path fpath

# Set the zsh function search path.
fpath=($HOME/.zsh/functions $fpath)

# Set the library search path.
export HOME_LOCAL=$HOME/.local
ld_library_path=($HOME_LOCAL/lib $ld_library_path)

# Alias definitions.
alias grep="grep --color=auto -I"
alias fgrep="fgrep -I -s"
alias less="less -R"
alias ls="ls --color=auto"
alias vi="nvim"
alias vim="nvim"
alias urxvt="urxvt -tr -sh 15"
alias ctags_cpp="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R *"
alias dia="dia --integrated $*"
alias parallel="parallel --env PYTHONPATH --no-notice"
alias please="sudo !!"

# Set environment variables.
export QTDIR=/usr/local/Trolltech/Qt/

# Configure ccache to be used for gcc/g++.
export CC="ccache gcc"
export CXX="ccache g++"

# Setup the default editor.
if [ -x $HOME_LOCAL/bin/nvim ]
then
    export EDITOR=$HOME_LOCAL/bin/nvim
else
    if [ -x $HOME_LOCAL/bin/vim ]
    then
        export EDITOR=$HOME_LOCAL/bin/vim
    else
        if [ -x /usr/bin/vim ]
        then
            export EDITOR=/usr/bin/vim
        fi
    fi
fi

# Don't keep a history file for less.
export LESSHISTFILE=/dev/null

# Let QtGtkStyle know about the current GTK2 theme.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Make sure locally installed terminfo files are found.
export TERMINFO="$HOME_LOCAL/share/terminfo"

# Use st as the default terminal.
export TERMINAL=st

# Disable virtualenv prompt by default (we handle it ourselves).
export VIRTUAL_ENV_DISABLE_PROMPT=1

# In case a machine local configuration must be set, do so here.
test -f $HOME/.zshenv.$(hostname) && source $HOME/.zshenv.$(hostname)
