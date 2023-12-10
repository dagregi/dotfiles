export RUSTC_WRAPPER=sccache

export BAT_THEME="ansi"
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:#191724,hl:#ebbcba
    --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
    --color=border:#403d52,header:#31748f,gutter:#191724
    --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa""
"

export GIT_EDITOR=$EDITOR

export PATH="$HOME/.local/bin:$PATH"
# export each directory in .local/bin
for dir in $HOME/.local/bin/*/; do
	export PATH="$dir:$PATH"
done

export PATH="$HOME/.cargo/bin:$PATH"
# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit

autoload edit-command-line; zle -N edit-command-line

bindkey -s ^f "tmux-sessionizer\n"
bindkey ^e edit-command-line
bindkey -v
