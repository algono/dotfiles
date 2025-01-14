# Dotfiles

## Table of contents
- [Dependencies](#dependencies)
  - [System Packages](#system-packages)
    - [Ubuntu](#ubuntu)
    - [Arch](#arch)
  - [Git Repositories](#git-repositories)
  - [Other Packages](#other-packages)
    - [Cargo](#cargo)
    - [Go](#go)
  - [Installation Script](#installation-script)
    - [Ubuntu](#ubuntu-1)
    - [Arch](#arch-1)
  - [Change shell to ZSH (Optional)](#change-shell-to-zsh-optional)
- [How to clone this repo](#how-to-clone-this-repo)
  - [Packages needed](#packages-needed)
    - [Ubuntu](#ubuntu-2)
    - [Arch](#arch-2)
  - [Script](#script)
  - [Explanation](#explanation)

## Dependencies
### System Packages
#### Ubuntu
- [autojump](https://github.com/wting/autojump) *(Ubuntu 20.10 or earlier)*
- [zoxide](https://github.com/ajeetdsouza/zoxide) *(Ubuntu 21.04 or later)*
- neofetch
- zsh
- zsh-syntax-highlighting
- zsh-autosuggestions
- cargo *(Ubuntu 20.04 or earlier)*
- [eza](https://github.com/eza-community/eza) *(Ubuntu 20.10 or later)*
- [bat](https://github.com/sharkdp/bat)

#### Arch
##### Pacman

- [neofetch](https://archlinux.org/packages/?name=neofetch)
- [eza](https://archlinux.org/packages/?name=eza)
- [bat](https://github.com/sharkdp/bat)
- [zsh](https://archlinux.org/packages/?name=zsh)
- [zsh-syntax-highlighting](https://archlinux.org/packages/?name=zsh-syntax-highlighting)
- [zsh-autosuggestions](https://archlinux.org/packages/?name=zsh-autosuggestions)
- [zsh-theme-powerlevel10k](https://archlinux.org/packages/?name=zsh-theme-powerlevel10k)
- [zoxide](https://archlinux.org/packages/community/x86_64/zoxide)

##### AUR

- [ttf-meslo-nerd-font-powerlevel10k](https://aur.archlinux.org/packages/ttf-meslo-nerd-font-powerlevel10k/)

### Git repositories
*(These are **NOT** needed for **arch** users - There are already arch packages for them)*
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) *(Powerlevel10k recommended font)*
### Other Packages
#### Cargo
- [eza](https://github.com/eza-community/eza) *(Ubuntu 20.04 or earlier)*

### Installation script
#### Ubuntu
##### Automatic
[Script](deps-ubuntu.sh)
##### Manual
```shell
# ---
# Ubuntu 20.04 or earlier
sudo apt install cargo
cargo install eza

# Ubuntu 20.10 or later
sudo apt install eza
# ---

# ---
# Ubuntu 20.10 or earlier
sudo apt install autojump

# Ubuntu 21.04 or later
sudo apt install zoxide
# ---

sudo apt install neofetch bat zsh zsh-syntax-highlighting zsh-autosuggestions 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

For the `MesloLGS NF` font, it's probably better to just follow the instructions from the [powerlevel10k README](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k).
#### Arch

##### Automatic
[Script](deps-arch.sh)
##### Manual
*(these commands use `paru` to install AUR packages)*
```shell
sudo pacman -S zoxide neofetch eza bat zsh zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k
paru -S ttf-meslo-nerd-font-powerlevel10k
```

### Change shell to ZSH (optional)
```shell
chsh $USER -s /bin/zsh
```

## How to clone this repo

### Packages needed
This method requires `stow` for creating symlinks and `ed` for custom `.bashrc` support.

> **Note**: The **automatic** scripts for installing dependencies also install these packages.
#### Ubuntu
```shell
sudo apt install stow ed
```
#### Arch
```shell
sudo pacman -S --needed stow ed
```

### Script
#### Automatic
[Script](setup.sh)
#### Manual
```shell
git clone https://github.com/algono/dotfiles ~/dotfiles

if [ -f ~/.bashrc ]; then mv -f ~/.bashrc ~/dotfiles/bash
elif [ -f /etc/skel/.bashrc ]; then cp -f /etc/skel/.bashrc ~/dotfiles/bash
elif uname -r | grep -iq manjaro; then cp ~/dotfiles/.bash-presets/.bashrc-manjaro ~/dotfiles/bash/.bashrc
else cp ~/dotfiles/.bash-presets/.bashrc-wsl ~/dotfiles/bash/.bashrc
fi

[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak

ed ~/dotfiles/bash/.bashrc < ~/dotfiles/.patches/bashrc-patch.ed

find ~/dotfiles/* -maxdepth 1 -name ".*" -o -type d -prune -printf "%f\n" | xargs /usr/bin/stow -d ~/dotfiles -t ~
```
### Explanation
> Clone repo in dotfiles directory
```shell
git clone https://github.com/algono/dotfiles ~/dotfiles
```
> If there is a custom *.bashrc* (either in the user's personal folder or in the system's *skel* folder), use it as a base.
> As a fallback, if the system is detected as manjaro, use the default manjaro *.bashrc*, and if it wasn't use the default WSL one
```shell
if [ -f ~/.bashrc ]; then mv -f ~/.bashrc ~/dotfiles/bash 
elif [ -f /etc/skel/.bashrc ]; then cp -f /etc/skel/.bashrc ~/dotfiles/bash
elif uname -r | grep -iq manjaro; then cp ~/dotfiles/bash/.bashrc-manjaro ~/dotfiles/bash/.bashrc
else cp ~/dotfiles/bash/.bashrc-wsl ~/dotfiles/bash/.bashrc
fi
```
> If there is a *.zshrc* file in the home folder, rename it
> (stow would fail if it finds a file there)
```shell
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
```
> Use the *ed* command to apply the relevant changes to the custom *.bashrc* file (Note: You should backup `~/.bashrc` first if you have that file, as this method has not been extensively tested and it could break it)
```shell
ed ~/dotfiles/bash/.bashrc < ~/dotfiles/.patches/bashrc.patch.ed
```
> Create symlinks for our dotfiles into the home directory
> (this command matches all non-hidden directories inside the 'dotfiles' folder)
```shell
find ~/dotfiles/* -maxdepth 1 -name ".*" -o -type d -prune -printf "%f\n" | xargs /usr/bin/stow -d ~/dotfiles -t ~
```

### The last command didn't work. It told me that some files were going to be overwritten and failed.
If you already have some of the files from this repo, the last command will warn you and won't run.

`Stow` does not have any option to overwrite files, so you can either **make backups** of these files *(example: `mv .dotfile .dotfile.bak`)*, or just **delete them**, and then re-run the last command.
