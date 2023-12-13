PROMPT='%B${vcs_info_msg_0_}%b
'
PROMPT+='%B%F{111}%2~%f %b%(?:%F{cyan}❯%f :%F{red}❯%f ) '

# Exports
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$XDG_DATA_HOME/zsh_history

export LANG=en_US.UTF8
export LC_ALL=en_US.UTF-8

for lib in $XDG_CONFIG_HOME/zsh/include/*; do
	source $lib
done

source /usr/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
