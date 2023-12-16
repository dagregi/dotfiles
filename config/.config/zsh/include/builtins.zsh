# Vi
bindkey -v
export KEYTIMEOUT=1
autoload -U colors && colors
setopt PROMPT_SUBST
setopt auto_cd
stty stop undef
autoload -U compinit
zstyle ":completion:*" menu select
[ -z "$LS_COLORS" ] || zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zmodload zsh/complist
compinit
# more vim
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
autoload edit-command-line; zle -N edit-command-line
bindkey ^e edit-command-line
