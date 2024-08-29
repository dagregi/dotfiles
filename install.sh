#!/bin/sh

show_progress() {
	local msg="$1"
	local color="$2"
	local pid=$3
	local delay=0.1
	local spin="-\|/"
	[ -z "$4" ] || mod="$4"

	echo -n "$mod\033[1;${color}m[$msg] \033[0m"
	while [ -d /proc/"$pid" ]; do
		local temp=${spin#?}
		printf " %c  " "$spin"
		local spin=$temp${spin%"$temp"}
		printf "\b\b\b\b"
		sleep $delay
	done
	printf "\b"
	echo " Done!"
}

install_packages() {
	local packages="$@"
	echo -n "\033[1;34m[Installing packages]\n\033[0m"
	for package in $packages; do
		sudo xbps-install -y $package >/dev/null 2>&1 &
		show_progress "Installing $package" 35 $! "\t"
	done
}

clone_repositories() {
	local repos="$@"
	for repo in $repos; do
		git clone --recursive "$repo" >/dev/null 2>&1 &
		show_progress "Cloning $(basename "$repo")" 35 $!
	done
}
symlink_configurations() {
	[ ! -d "$HOME/.config" ] && mkdir -p "$HOME/.config"
	mkdir -p "$HOME/.local/share" "$HOME/.local/bin"
	cd dotfiles
	for dir in */; do
		trdir=$(echo "$dir" | tr -d '/')
		stow -S $trdir -t ~/ >/dev/null 2>&1 &
		show_progress "Symlinking $trdir" 35 $! "\t"
	done
	cd -
}
install_st() {
	cd st
	sudo make install >/dev/null 2>&1 &
	show_progress "Installing st" 34 $!
	cd -
}
install_slock() {
	ln -s "$(pwd)/slock" "$HOME/.local/share"
	cd slock
	sudo make install >/dev/null 2>&1 &
	show_progress "Installing slock" 34 $!
	cd -
}
install_fonts() {
	[ ! -d "$HOME/.local/fonts" ] && mkdir -p "$HOME/.local/fonts/TTF"
	cd "$HOME/.local/fonts/TTF"
	curl -sSf -LO https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Medium/JetBrainsMonoNerdFont-Medium.ttf &
	curl -sSf -LO https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Iosevka/IosevkaNerdFont-SemiBold.ttf
	sudo ln -s $HOME/.local/fonts/TTF/* /usr/share/fonts/TTF/
	show_progress "Installing fonts" 36 $!
	cd ~
}

sudo xbps-install -Suy xbps
clear
sudo xbps-install -Suy >/dev/null 2>&1 &
show_progress "Updating system" 33 $!

install_packages xorg-minimal xprop xclip xdo xsetroot xset xrandr xrdb setxkbmap xcape xmodmap \
	mesa-dri mesa-vaapi libX11-devel libXft-devel pkg-config make gcc rust-sccache
clear
install_packages git tmux neovim zsh zsh-syntax-highlighting zsh-autosuggestions \
	yt-dlp bat eza ripgrep fzf brillo gnupg pass stow dbus alsa-utils libsixel chafa
install_packages bspwm sxhkd rofi picom polybar feh lf mpd mpc \
	ncmpcpp mpv dunst newsboat nsxiv shotgun slop ffmpeg ffmpegthumbnailer \
	zathura zathura-pdf-mupdf mediainfo-cli atool

mkdir -p "$HOME/projects" && cd "$HOME/projects"

clone_repositories "git@github.com:dagregi/dotfiles.git" "git@github.com:dagregi/st.git" "git@github.com:dagregi/slock.git"
symlink_configurations
install_st
install_slock
install_fonts

echo "\n\033[1;32mCustom install script completed!\033[0m"
