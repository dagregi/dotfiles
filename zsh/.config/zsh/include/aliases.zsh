# Aliases
alias vim=$EDITOR
# DIRS
alias -g ...='../..' \
	....='../../..'
alias ls='eza --color=auto --icons=always --group-directories-first' \
	la='ls -la' \
	ll='ls -l' \
alias cat='bat --style=plain --paging=never'
# GIT: Stats
alias gls='git --no-pager log --oneline --graph -20'
alias gwhat='git whatchanged --oneline --graph --stat'
# CONFIG
alias reloadst='xrdb merge $XDG_CONFIG_HOME/X11/xresources && kill -USR1 $(pidof st)'
# XBPS
alias xin='sudo xbps-install -S $(xbps-query -Rs "" | sed "/^.\*./d" | awk "{print \$2}" | fzf -m -e)' \
	xrm='sudo xbps-remove -oR $(xbps-query -s "" | awk "{print \$2}" | fzf -m -e)' \
	xq='xbps-query $(xbps-query -l | sed "s/-[0-9].*//; s/^ii\s//" | fzf -e)'
# NIX
alias update-cargo-nix='crate2nix generate && patch Cargo.nix < filter.patch && rm -f Cargo.nix.orig'
