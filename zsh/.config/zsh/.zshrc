PROMPT='%B%F{11}%n%f%F{2}@%f%F{5}%M%f %F{14}%2~%f ${vcs_info_msg_0_}%b%(?:%F{11}❯%f:%F{1}❯%f) '

zmodload zsh/complist
autoload -Uz compinit
[ ! "$(find $ZDOTDIR/.zcompdump -mtime +1)" ] || compinit
compinit -C
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

bindkey -s '^f' "^utmux-sessionizer\n"

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{#908caa}* %b%f %m'
zstyle ':vcs_info:git*+set-message:*' hooks git-st
+vi-git-st() {
	local ahead behind
	local -a gitstatus

	git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0
	local -a ahead_and_behind=($(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null))

	ahead=${ahead_and_behind[1]}
	behind=${ahead_and_behind[2]}
	(( $ahead )) && gitstatus+=( "%F{1}${ahead}%f " )
	(( $behind )) && gitstatus+=( "%F{1}${behind}%f " )

	hook_com[misc]+=${(j:/:)gitstatus}
}
precmd() { vcs_info }

export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$XDG_DATA_HOME/zsh_history

lfcd() {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
mkcd() {
	dir="$*" && mkdir -p "$dir" && cd "$dir"
}

source $ZDOTDIR/include/aliases.zsh
source $ZDOTDIR/include/builtins.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
