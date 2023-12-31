autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats 'on %F{110} %b%f  [%c%u %m]'
zstyle ':vcs_info:git:*' actionformats '(%F{110}%a%f)'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{red}󰍴%f'
zstyle ':vcs_info:git:*' stagedstr '%F{green} %f'
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-untracked

+vi-git-untracked(){
	[[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] &&
	git status --porcelain | grep -q '^?? ' 2> /dev/null &&
	hook_com[staged]+='%F{red}? %f'
}
+vi-git-st() {
	local ahead behind
	local -a gitstatus

	git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0
	local -a ahead_and_behind=($(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null))

	ahead=${ahead_and_behind[1]}
	behind=${ahead_and_behind[2]}
	(( $ahead )) && gitstatus+=( "%F{yellow} ${ahead}%f" )
	(( $behind )) && gitstatus+=( "%F{yellow} ${behind}%f" )

	hook_com[misc]+=${(j:/:)gitstatus}
}

precmd() { vcs_info }
