eval "$(starship init zsh)"

export LANG=en_US.UTF8
export LC_ALL=en_US.UTF-8


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Exports
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$XDG_DATA_HOME/zsh_history

source $XDG_CONFIG_HOME/zsh/include/aliases.zsh
source $PREFIX/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PREFIX/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
