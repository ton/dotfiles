# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Enable recursive wildcards.
setopt ExtendedGlob

# Diable rm star confirmation.
setopt rmstarsilent

# Append to the history file, don't overwrite it, and share history between
# terminals.
export HISTSIZE=50000
export HISTFILE=$HOME/.history
export SAVEHIST=50000
setopt IncAppendHistory HistIgnoreAllDups

# Enable advanced command line completion.
autoload -U compinit && compinit

# Enable command line calculator.
autoload -U zcalc

# Load function to show the active git branch in the prompt.
autoload -U git-branch
autoload -U sandbox-info
setopt PromptSubst

# Remove rprompt indent (only needed for ancient terminals).
export ZLE_RPROMPT_INDENT=-1
export RPROMPT='$(sandbox-info)'

# Disable flow control characters C-s and C-q so they can be used as shortcuts
# in Vim in case we are running in an interactive shell.
if [[ $- == *i* ]]
then
    stty -ixon -ixoff
fi

# Enable vi mode for command-line editing.
bindkey -v

# Remap control-r to map to backward incremental history search.
bindkey "^R" history-incremental-search-backward

# Make sure that Esc-/ also maps to incremental history search, and at the same
# time enters Vi mode.
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# Make sure that backspace works past the point where we entered insert mode.
bindkey "^?" backward-delete-char

# Let control+backspace delete the last word, and set sane word separators.
bindkey "^H" backward-delete-word
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Map the home and end keys.
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char

# Make sure environment variables only contain unique entries.
typeset -U path

# Evaluate ls colors.
eval $(dircolors ~/.dircolors)

# Unfortunately, we need to set PATH in .zshrc under Arch.
path=($HOME/.local/bin $path)

# In case a machine local configuration must be set, do so here.
test -f $HOME/.zshrc.local && source $HOME/.zshrc.local

# Disable shell reserved time word, use time provided by Linux.
disable -r time
