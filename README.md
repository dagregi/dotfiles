# dotfiles

My dotfiles for void linux

## Installation

### Fresh Installation

I mainly use the below command to setup my fresh Void Linux install, so it only works on Void Linux.
It's a quick and dirty way to setup my system, you can try it if you're feeling lucky :)

```shell
curl -fsSL https://raw.githubusercontent.com/dagregi/dotfiles/main/install.sh | sh
```

### Existing Setup

If you already have a running setup and want to integrate these dotfiles, follow these steps:

1. **Clone the Repository:**

    ```shell
    git clone --recursive https://github.com/dagregi/dotfiles.git
    cd dotfiles
    ```

2. **Backup Existing Configurations:**

    ```shell
    mv ~/.config ~/.config.bak
    ```

3. **Install Using Stow:**

    ```shell
    # to install all the configs
    stow */ --target <target-location>
    # or if you have a specific packages in mind
    stow polybar rofi
    ```

4. **Alternative:**

    If you don't have stow you can directly copy the configs

    ```shell
    cp -vir */.config ~/
    cp -vir local/.local/bin/* ~/.local/bin
    cp -vir local/.local/share/* ~/.local/share
    ```
