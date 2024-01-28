addToPath() {
	if [ "$PATH" != "$1" ]; then
		export PATH="$1:$PATH"
	fi
}

export RUSTC_WRAPPER=sccache
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=01;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32'
export BAT_THEME="Coldark-Dark"
export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:#191724,hl:#ebbcba
    --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
    --color=border:#403d52,header:#31748f,gutter:#191724
    --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa""
"
export GIT_EDITOR=$EDITOR

addToPath "$HOME/.local/bin"
for dir in $HOME/.local/bin/*/; do
	addToPath $dir
done
addToPath $HOME/.cargo/bin
addToPath $GOPATH/bin

test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[46;30m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;35m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	exec startx ~/.config/X11/xinitrc
fi
