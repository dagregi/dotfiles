# Aliases
alias vim=$EDITOR
alias pg_start='pg_ctl -D $PREFIX/var/lib/postgresql start'
alias pg_stop='pg_ctl -D $PREFIX/var/lib/postgresql stop'

# DIRS
alias -g ...='../..' \
	....='../../..'
alias ls='eza --color=auto --icons=always --group-directories-first' \
	la='ls -la' \
	ll='ls -l' \
alias del='rm -rvI' \
	cp='cp -riv' \
	mv='mv -iv'
alias md='mkdir -p'

alias cat='bat --style=plain --paging=never'
alias lf='lfub'

# GIT: Stats
alias gcl='git clone --recursive'
alias gls='git --no-pager log --oneline --graph -20'
alias gstat='git status -s'
alias gwhat='git whatchanged --oneline --graph --stat'
# GIT: Locals
alias ga='git add'
alias gaa='git add .'
alias gap='git add --patch'
alias gs='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gscls='git stash clear'
# GIT: Commit
alias gcam='git commit -am'
alias gcm='git commit -m'
alias gce='git commit --amend --no-edit'
alias gcs='git commit --squash'
alias gcf='git commit --fixup'
# GIT: Rebase
alias gri='git rebase --interactive --autostash'
alias grf='git rebase --interactive --autosquash'
alias grx='git rebase --abort'
alias grr='git rebase --continue'
# GIT: Branch
alias gb='git branch'
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
alias reloadst="xrdb merge $HOME/.Xresources && kill -USR1 $(pidof st)"
