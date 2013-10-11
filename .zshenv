# Make sure environment variables only contain unique entries.
typeset -U ld_library_path fpath

# Set the zsh function search path.
fpath=($HOME/.zsh/functions $fpath)

# Set the library search path.
ld_library_path=($HOME/local/lib $ld_library_path)

export PATH=$HOME/bin:$PATH:/usr/local/Trolltech/Qt/bin:/usr/lib/ccache/bin

# Set environment variables.
export QTDIR=/usr/local/Trolltech/Qt/

# Configure ccache.
export CCACHE_DIR=$HOME/.ccache
export CC="ccache gcc"
export CXX="ccache g++"

# Setup the default editor.
if [ -x /usr/local/bin/vim ];
then
    export EDITOR=/usr/local/bin/vim
else
    export EDITOR=/usr/bin/vim
fi

# Don't keep a history file for less.
export LESSHISTFILE=/dev/null

# Let QtGtkStyle know about the current GTK2 theme.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# In case machine local environment variables must be set, do so here.
test -f $HOME/.zshenv.local && source $HOME/.zshenv.local
