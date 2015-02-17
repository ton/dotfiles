# Make sure environment variables only contain unique entries.
typeset -U ld_library_path fpath

# Set the zsh function search path.
fpath=($HOME/.zsh/functions $fpath)

# Set the library search path.
ld_library_path=($HOME/local/lib $ld_library_path)

# Alias definitions.
alias grep="grep --color=auto -I"
alias fgrep="fgrep -I -s"
alias less="less -R"
alias ls="ls --color=auto"
alias vi="vim"
alias urxvt="urxvt -tr -sh 15"
alias ctags_cpp="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R *"
alias vim="vim --servername VIM $*"
alias dia="dia --integrated $*"
alias parallel="parallel --env PYTHONPATH --no-notice"
alias please="sudo !!"

# Set environment variables.
export QTDIR=/usr/local/Trolltech/Qt/

# Configure ccache to be used for gcc/g++.
export CC="ccache gcc"
export CXX="ccache g++"

# Setup the default editor.
if [ -x ${HOME}/local/bin/vim ];
then
    export EDITOR=${HOME}/local/bin/vim
else
    export EDITOR=/usr/bin/vim
fi

# Don't keep a history file for less.
export LESSHISTFILE=/dev/null

# Let QtGtkStyle know about the current GTK2 theme.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Use termite as the default terminal.
export TERMINAL=termite

# In case a machine local configuration must be set, do so here.
test -f $HOME/.zshenv.local && source $HOME/.zshenv.local
