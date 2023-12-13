# Vi bindings
bindkey -v

autoload -U colors && colors

setopt PROMPT_SUBST
setopt auto_cd

autoload -U compinit
zstyle ":completion:*" menu select
[ -z "$LS_COLORS" ] || zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zmodload zsh/complist
compinit

autoload edit-command-line; zle -N edit-command-line
bindkey ^e edit-command-line
