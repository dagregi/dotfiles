eval "$(starship init zsh)"

# Exports
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$XDG_DATA_HOME/zsh_history

export LANG=en_US.UTF8
export LC_ALL=en_US.UTF-8

source $XDG_CONFIG_HOME/zsh/include/aliases.zsh
source $PREFIX/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PREFIX/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
