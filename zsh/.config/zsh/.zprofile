export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

addToPath() {
	if [ "$PATH" != "$1" ]; then
		export PATH="$1:$PATH"
	fi
}

addToPath "$HOME/.local/bin"
addToPath "$HOME/.local/bin/rofi"
addToPath "$HOME/.local/bin/bspwm"
addToPath $CARGO_HOME/bin
addToPath $GOPATH/bin

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec startx ~/.config/X11/xinitrc
fi
