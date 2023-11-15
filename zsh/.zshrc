eval "$(starship init zsh)"

# Plugins
plugins=(
    zsh-syntax-highlighting
    git
)

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/catppuccin_mocha-zsh-syntax-highlighting.zsh
# source ~/.profile

export LANG=en_US.UTF8
export LC_ALL=en_US.UTF-8


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.local/zsh_history

# Aliases
alias vim=$VIM
alias pg_start='pg_ctl -D $PREFIX/var/lib/postgresql start'
alias pg_stop='pg_ctl -D $PREFIX/var/lib/postgresql stop'

alias del='rm -rf'
alias ex='exit'
alias cls='clear'

# Exports
export BAT_THEME="Catppuccin-mocha"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# pnpm
export PNPM_HOME="/data/data/com.termux/files/home/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
