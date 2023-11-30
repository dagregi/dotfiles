# Aliases
alias vim=$VIM
alias pg_start='pg_ctl -D $PREFIX/var/lib/postgresql start'
alias pg_stop='pg_ctl -D $PREFIX/var/lib/postgresql stop'

alias del='rm -rf'

# GIT: Stats
alias gcl='git clone --recursive'
alias gls='git --no-pager log --oneline --graph -20'
alias gstat='git status -s'
alias gwhat='git whatchanged --oneline --graph --stat'
# GIT: Locals
alias gap='git add --patch'
alias gcam='git commit -am'
alias gcm='git commit -m'
# GIT: Branch
alias gbrm='git branch -d'
alias gch='git checkout'
alias gcb='git checkout -b'
# GIT: Remote
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gp='git push'
alias gpu='git push -u origin $(git_current_branch)'
alias yolo='git push --force'
alias gra='git remote add'
alias grrm='git remote remove'

# CONFIG
alias reloadst="xrdb merge $XDG_CONFIG_HOME/.Xresources && kill -USR1 $(pidof st)"
