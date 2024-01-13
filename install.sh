#!/bin/sh

show_progress() {
	local msg="$1"
	local color="$2"
	local pid=$3
	local delay=0.1
	local spin="-\|/"
	local count=0

	echo -n "\033[1;${color}m[$msg] \033[0m"
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
	echo -n "\033[1;34m[Installing packages] \033[0m"
	for package in $packages; do
		xbps-install -y $package >/dev/null 2>&1 &
		show_progress "\tInstalling $package" 35 $!
	done
}

clone_repositories() {
	local repos="$@"
	for repo in $repos; do
		git clone --depth 1 --recursive "$repo" >/dev/null 2>&1 &
		show_progress "Cloning $(basename "$repo")" 35 $!
	done
}
symlink_configurations() {
	local configurations="$@"
	[ ! -d "$HOME/.config" ] && mkdir -p "$HOME/.config"
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local"
	cd dotfiles
	stow -S $configurations >/dev/null 2>&1
	show_progress "Symlinking configs" 34 $!
	cd ~
}
install_st_terminal() {
	cd st
	sudo make install >/dev/null 2>&1 &
	show_progress "Installing st terminal" 34 $!
	cd ~
}

clear
xbps-install -Suy >/dev/null 2>&1 &
show_progress "Updating system" 33 $!
install_packages base-system xorg-minimal xprop xbacklight xclipboard xsetroot xf86-input-evdev xf86-video-amdgpu openssl-devel libX11-devel libXft libXft-devel pkg-config pkgconf-devel make fontconfig freetype fontconfig-devel freetype-devel
install_packages git tmux neovim zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions yt-dlp bat fd eza ripgrep fzf gnupg pass stow mediainfo-cli gnome-epub-thumbnailer atool odt2text
install_packages bspwm sxhkd rofi picom polybar feh betterlockscreen lf ueberzug cava mpd mpc ncmpcpp mpv dunst newsboat htop sxiv ffmpeg ffmpegthumbnailer pulseaudio zathura zathura-pdf-mupdf zathura-djvu

clone_repositories "git@github.com:dagregi/dotfiles.git" "git@github.com:dagregi/st.git"
symlink_configurations "bin" "config"
install_st_terminal
sh ~/dotfiles/setup.sh

echo "\n\033[1;32mCustom install script completed!\033[0m"
