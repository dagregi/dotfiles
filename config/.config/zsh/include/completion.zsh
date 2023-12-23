zmodload zsh/complist
autoload -U compinit; compinit
setopt COMPLETE_IN_WORD
setopt AUTO_MENU
setopt AUTO_LIST
setopt EXTENDED_GLOB

zstyle ":completion:*" menu select
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' file-sort name
[ -z "$LS_COLORS" ] || zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%B%F{cyan}--%d--%f%b'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) '
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}--no matches found--%f'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
