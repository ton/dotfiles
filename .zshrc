# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Set the correct path (ideally, this should be done from .zshenv, but is
# problematic, see: https://bugs.archlinux.org/task/35966.
typeset -U path
path=($HOME/bin $path /usr/local/Trolltech/Qt/bin /usr/lib/ccache/bin)

# Enable recursive wildcards.
setopt ExtendedGlob

# Append to the history file, don't overwrite it, and share history between
# terminals.
export HISTSIZE=1000
export HISTFILE=$HOME/.history
export SAVEHIST=1000
setopt IncAppendHistory HistIgnoreAllDups

# Enable advanced command line completion.
autoload -U compinit && compinit

# Enable command line calculator.
autoload -U zcalc

# Load function to show the active git branch in the prompt.
autoload -U git-branch && git-branch
setopt PromptSubst

# Set prompt.
export PROMPT='%n@%F{154}%B%m%F{255}:%F{12}%~%b%F{255}$(git-branch "|%%B%%F{245}%s%%F{255}%%b")$ '

# Alias definitions.
alias grep="grep --color=auto -I"
alias fgrep="fgrep -I -s"
alias less="less -R"
alias ls="ls --color=auto"
alias vi="vim"
alias urxvt="urxvt -tr -sh 15"
alias ctags_cpp="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R *"
alias vim="vim --servername VIM $*"
alias parallel="parallel --env PYTHONPATH"

# Disable flow control characters C-s and C-q so they can be used as shortcuts
# in Vim in case we are running in an interactive shell.
if [[ $- == *i* ]]
then
    stty -ixon -ixoff
fi

# Enable vi mode for command-line editing.
bindkey -v

# Remap slash to map to incremental history search.
bindkey -M vicmd '/' history-incremental-search-backward

# Make sure that Esc-/ also maps to incremental history search, and at the same
# time enters Vi mode.
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# Make sure that backspace works past the point where we entered insert mode.
bindkey "^?" backward-delete-char

# In case a machine local configuration must be set, do so here.
test -f $HOME/.zshrc.local && source $HOME/.zshrc.local
