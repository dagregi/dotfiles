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
	xbps-install -y "$packages" >/dev/null 2>&1 &
	show_progress "Installing packages" 34 $!
}

clone_repositories() {
	local repos="$@"
	for repo in $repos; do
		git clone --recursive "$repo" >/dev/null 2>&1 &
		show_progress "Cloning $(basename "$repo")" 35 $!
	done
}
symlink_configurations() {
	local configurations="$@"
	[ ! -d "$HOME/.config" ] && mkdir -p "$HOME/.config"
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local"
	(cd dotfiles || exit 1 && stow -S "$configurations" && cd ~ || exit 1) >/dev/null 2>&1 &
	show_progress "Symlinking configs" 34 $!
}
install_st_terminal() {
	(cd st || exit 1 && sudo make install && cd ~ || exit 1) >/dev/null 2>&1 &
	show_progress "Installing st terminal" 34 $!
}

install_dependencies() {
	xbps-install -y base-devel gcc bubblewrap rust-sccache >/dev/null 2>&1 &
	show_progress "Installing dependencies" 34 $!
}
install_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -- -y >/dev/null 2>&1 &
	show_progress "Installing Rust" 34 $!
	rustup component add rustfmt rust-analyzer clippy >/dev/null 2>&1 &
	show_progress "Installing Rust tools" 34 $!
	rustup target add wasm32-unknown-unknown >/dev/null 2>&1 &
	show_progress "Installing Rust target" 34 $!
	rustup completions zsh >/usr/share/zsh/functions/Completion/Linux/_rustup && rustup completions zsh cargo >/usr/share/zsh/functions/Completion/Linux/_cargo >/dev/null 2>&1 &
	show_progress "Setting up Rust completions" 34 $!
}
install_opam() {
	bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)" >/dev/null 2>&1 &
	show_progress "Installing Opam" 34 $!
	opam init &
	show_progress "Initializing Opam" 34 $!
	opam install dune merlin ocaml-lsp-server ocamlformat utop >/dev/null 2>&1 &
	show_progress "Setting up Ocaml environment" 34 $!
}
install_go() {
	xbps-install -y go >/dev/null 2>&1 &
	show_progress "Installing Go" 34 $!
}
install_node() {
	xbps-install -y nodejs nodejs-devel >/dev/null 2>&1 &
	show_progress "Installing Node" 34 $!
	npm install -g npm >/dev/null 2>&1 &
	show_progress "Installing npm" 34 $!
}
install_postgresql() {
	xbps-install -y postgresql postgresql-client postgresql-libs >/dev/null 2>&1 &
	show_progress "Installing PostgreSQL" 34 $!
	sudo -u postgres initdb -D /var/lib/postgres/data >/dev/null 2>&1 &
	show_progress "Initializing PostgreSQL" 34 $!
}

xbps-install -Suy >/dev/null 2>&1 &
show_progress "Updating system" 33 $!
install_packages base-system xorg-minimal xf86-input-evdev xf86-video-amdgpu git tmux neovim zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions curl yt-dlp bat fd eza ripgrep fzf gnupg pass openssl-devel stow
install_packages bspwm sxhkd rofi picom polybar feh betterlockscreen lf cava mpd mpc ncmpcpp mpv dunst newsboat htop

clone_repositories "https://github.com/dagregi/dotfiles.git" "https://github.com/dagregi/st.git"
symlink_configurations "bin" "config"
install_st_terminal

read -p "Do you want to setup developmental environment? [y/N] " choice
case "$choice" in
y | Y) {
	install_dependencies
	install_node
	install_go
	install_postgresql
	install_rust
	install_opam
} ;;
*) echo "Skipping setup" ;;
esac

echo "\n\033[1;32mCustom install script completed!\033[0m"
