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

# Hard disk space is cheap.
export CCACHE_MAXSIZE=12G

# Don't keep a history file for less.
export LESSHISTFILE=/dev/null

# Let QtGtkStyle know about the current GTK2 theme.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Use Neovim as a pager.
export AUR_PAGER="nvim"
export MANPAGER="/usr/bin/nvim +Man!"

# Make sure locally installed terminfo files are found.
export TERMINFO="$HOME_LOCAL/share/terminfo"

# Use st as the default terminal, ensure COLORTERM is set to 24bit to enable
# true color support in notcurses for example.
export TERMINAL=st
export COLORTERM=24bit

# Disable virtualenv prompt by default (we handle it ourselves).
export VIRTUAL_ENV_DISABLE_PROMPT=1

# In case a machine local configuration must be set, do so here.
test -f $HOME/.zshenv.$(hostname) && source $HOME/.zshenv.$(hostname)

# In case no host color is set, set some default.
host_color=${host_color:=154}

maybe_git_branch() {
    local branch=$(/usr/bin/git branch --show-current 2>/dev/null)
    if [ "x$branch" != "x" ]
    then
        printf "$1" "$branch"
    fi
}

if [ -z "${DISPLAY}" ]; then
    branch_icon="|"
else
    branch_icon="$(printf '\Uf062c ')"
fi
branch_color=245

export PROMPT='%(?.%F{2}.%F{1})$(date +%H:%M:%S)%F{243}|%F{255}%n@%F{$host_color}%B%m%F{255}:%F{12}%~%b%F{255}$(maybe_git_branch "$branch_icon%%F{${branch_color}}%s%%F{255}%%b")$ '
