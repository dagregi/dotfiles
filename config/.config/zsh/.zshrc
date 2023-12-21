PROMPT='%B${vcs_info_msg_0_}%b
'
PROMPT+='%B%F{magenta}%n%f%F{green}@%f%F{blue}%M%f %F{111}%2~%f %b%(?:%F{cyan}❯%f:%F{red}❯%f) '
for lib in $XDG_CONFIG_HOME/zsh/include/*; do
	source $lib
done
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
