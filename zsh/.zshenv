# Make sure environment variables only contain unique entries.
typeset -U ld_library_path fpath

# Set the zsh function search path.
fpath=($HOME/.zsh/functions $fpath)

# Set the library search path.
export HOME_LOCAL=$HOME/.local
ld_library_path=($HOME_LOCAL/lib $ld_library_path)

# Alias definitions.
alias colors="(x=\`tput op\` y=\`printf %76s\`;for i in {0..256};do o=00\$i;echo -e \${o:${#o}-3:3} \`tput setaf \$i;tput setab \$i\`\${y// /=}\$x;done)"
alias ctags_cpp="ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R *"
alias dia="dia --integrated $*"
alias fgrep="fgrep -I -s"
alias grep="grep --color=auto -I"
alias less="less -R"
alias ls="ls --color=auto"
alias parallel="parallel --env PYTHONPATH --no-notice"
alias please="sudo !!"
alias urxvt="urxvt -tr -sh 15"
alias vimdiff="nvim -d"
alias vim="nvim"
alias vi="nvim"
alias yt-dlp="yt-dlp -f 'bv+ba/b'"

# Set environment variables.
export QTDIR=/usr/local/Trolltech/Qt/

# Setup the default editor.
if [ -x $HOME_LOCAL/bin/nvim ]
then
    export EDITOR=$HOME_LOCAL/bin/nvim
elif [ -x $HOME_LOCAL/bin/vim ]
then
    export EDITOR=$HOME_LOCAL/bin/vim
elif [ -x /usr/bin/nvim ]
then
    export EDITOR=/usr/bin/nvim
elif [ -x /usr/bin/vim ]
then
    export EDITOR=/usr/bin/vim
fi

# Don't keep a history file for less.
export LESSHISTFILE=/dev/null

# Let QtGtkStyle know about the current GTK2 theme.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Use Neovim as a man pager.
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# Make sure locally installed terminfo files are found.
export TERMINFO="$HOME_LOCAL/share/terminfo"

# Use st as the default terminal.
export TERMINAL=st

# Disable virtualenv prompt by default (we handle it ourselves).
export VIRTUAL_ENV_DISABLE_PROMPT=1

# In case a machine local configuration must be set, do so here.
test -f $HOME/.zshenv.$(hostname) && source $HOME/.zshenv.$(hostname)
