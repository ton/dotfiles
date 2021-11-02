export PROMPT='%(?.%F{2}.%F{1})$(date +%H:%M:%S)%F{243}|%F{255}%n@%F{243}%B%m%F{255}:%F{12}%~%b%F{255}$(git-branch " \ue625 %%B%%F{245}%s%%F{255}%%b")$ '

export CCACHE_MAXSIZE=12G

fractal_root=$HOME/dev/fractal/

alias set-build=". $fractal_root/bin/switch-build.sh $*"
alias init-sandbox=". $fractal_root/bin/init-sandbox.sh $*"
alias cdi="cd $fractal_root/projects/ipdelta/setups/ST_IO_1"
alias cdt="cd $fractal_root/projects/ipdelta/setups/DEMO/IPDELTA"
alias cdl="cd $fractal_root/repos/fractal/largetests"
alias cdr="cd $fractal_root/repos/fractal/"
alias cds="cd $fractal_root/repos/fractal/src"

export TCLLIBPATH="/usr/lib/tclx8.4"
