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
	echo -n "\033[1;34m[Installing packages] \033[0m"
	for package in $packages; do
		sudo xbps-install -y $package >/dev/null 2>&1 &
		show_progress "Installing $package" 35 $! "\t"
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
	[ ! -d "$HOME/.config" ] && mkdir -p "$HOME/.config"
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local"
	cd dotfiles
	for dir in */; do
		trdir=$(echo "$dir" | tr -d '/')
		stow -R $trdir >/dev/null 2>&1 &
		show_progress "Symlinking $trdir" 35 $! "\t"
	done
	cd ~
}
install_st_terminal() {
	cd st
	sudo make install >/dev/null 2>&1 &
	show_progress "Installing st terminal" 34 $!
	cd ~
}
install_fonts() {
	[ ! -d "$HOME/.local/fonts" ] && mkdir -p "$HOME/.local/fonts/TTF"
	cd "$HOME/.local/fonts/TTF"
	curl -sSf -LO https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Medium/JetBrainsMonoNerdFont-Medium.ttf &
	curl -sSf -LO https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Semi-Bold/IosevkaNerdFont-SemiBold.ttf &
	show_progress "Installing fonts" 36 $!
	cd ~
}

clear
sudo xbps-install -Suy xbps >/dev/null 2>&1
sudo xbps-install -Suy >/dev/null 2>&1 &
show_progress "Updating system" 33 $!

install_packages base-system xorg-minimal xprop brightnessctl xclip xsetroot \
	xf86-input-evdev mesa-dri mesa-vaapi mesa-vdpau xf86-video-amdgpu openssl-devel libX11-devel libXft-devel \
	pkg-config make fontconfig-devel freetype-devel
install_packages git tmux neovim zsh zsh-syntax-highlighting zsh-autosuggestions yt-dlp bat fd eza ripgrep fzf gnupg pass stow pulseaudio libsixel
install_packages bspwm sxhkd rofi picom polybar feh betterlockscreen lf cava mpd \
	mpc ncmpcpp mpv dunst newsboat htop nsxiv shotgun slop ffmpeg ffmpegthumbnailer \
	zathura zathura-pdf-mupdf zathura-djvu mediainfo-cli gnome-epub-thumbnailer atool odt2text

clone_repositories "git@github.com:dagregi/dotfiles.git" "git@github.com:dagregi/st.git"
symlink_configurations
install_fonts
install_st_terminal

sh ~/dotfiles/setup.sh

echo "\n\033[1;32mCustom install script completed!\033[0m"
