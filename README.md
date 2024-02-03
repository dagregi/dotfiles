# dotfiles

My dotfiles for void linux

## Installing

If you're in a barebones fresh install of void run this command on the terminal
and hope that it works first try
```shell
curl -fsSL https://raw.githubusercontent.com/dagregi/dotfiles/main/install.sh | sh
```

or if you already have a running setup try this one below
```shell
git clone --recursive https://github.com/dagregi/dotfiles.git
mv .config .config.bak
cd dotfiles
# you need to install stow
stow */
# and if you don't like symlinking your configs
cp -vir */.config ~/
cp -vir local/.local/bin/* ~/.local/bin
cp -vir local/.local/share/* ~/.local/share
```
