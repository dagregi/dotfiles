PROMPT='%B${vcs_info_msg_0_}%b
'
PROMPT+='%B%F{11}%n%f%F{green}@%f%F{magenta}%M%f %F{14}%2~%f %b%(?:%F{11}❯%f:%F{red}❯%f) '
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/.zprofile
