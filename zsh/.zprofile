export XDG_CONFIG_HOME=$HOME/.config
export RUSTC_WRAPPER=sccache

export BAT_THEME="Catppuccin-mocha"
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:#191724,hl:#ebbcba
    --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
    --color=border:#403d52,header:#31748f,gutter:#191724
    --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa""
"
VIM="nvim"

export GIT_EDITOR=$VIM

export PATH="$XDG_CONFIG_HOME/scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

bindkey -s ^f "tmux-sessionizer\n"
