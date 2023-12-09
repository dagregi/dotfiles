eval "$(starship init zsh)"

# Plugins
plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

source $XDG_CONFIG_HOME/zsh/include/aliases.zsh

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
export HISTFILE=$HOME/.local/zsh_history

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
