# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Don't put duplicate lines in the history. See bash(1) for more options.
# Don't overwrite GNU Midnight Commander's setting of `ignorespace' ...
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

GIT_PROMPT_SCRIPT=/usr/share/git/completion/git-prompt.sh
if [ -f $GIT_PROMPT_SCRIPT ]; then
    source $GIT_PROMPT_SCRIPT
    PS1='\u@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "\[\033[01;00m\]|\[\033[01;30m\]%s\[\033[01;00m\]" )\$ '
else
    PS1='\u@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# If this is an xterm set the title to user@host:dir.
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Set environment variables.
export QTDIR=/usr/local/Trolltech/Qt/

# Set path and library path.
export PATH=$HOME/bin:$HOME/local/bin:/usr/local/Trolltech/Qt/bin/:/usr/local/bin:/usr/lib/ccache/bin/:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH

# Enable recursive wildcards.
shopt -s globstar

# Configure ccache.
export CCACHE_DIR=$HOME/.ccache
export CC="ccache gcc"
export CXX="ccache g++"

# Configure subversion.
export SVN_EDITOR=vim

# Don't keep a history file for less.
export LESSHISTFILE=/dev/null

# Add machine specific configuration.
if [ -e $HOME/.bash_local ]
then
    source $HOME/.bash_local
fi

# Disable flow control characters C-s and C-q so they can be used as shortcuts in Vim in case we are running in an
# interactive shell.
if [[ $- == *i* ]]
then
    stty -ixon -ixoff
fi

# Enable vi mode for command-line editing.
set -o vi
