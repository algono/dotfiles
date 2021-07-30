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
- [autojump](https://github.com/wting/autojump)
- neofetch
- zsh
- zsh-syntax-highlighting
- zsh-autosuggestions
- cargo *(Ubuntu 20.04 or earlier)*
- [exa](https://github.com/ogham/exa) *(Ubuntu 20.10 or later)*
- golang-go

#### Arch
##### Pacman

- [neofetch](https://archlinux.org/packages/?name=neofetch)
- [exa](https://archlinux.org/packages/?name=exa)
- [zsh](https://archlinux.org/packages/?name=zsh)
- [zsh-syntax-highlighting](https://archlinux.org/packages/?name=zsh-syntax-highlighting)
- [zsh-autosuggestions](https://archlinux.org/packages/?name=zsh-autosuggestions)
- [zsh-theme-powerlevel10k](https://archlinux.org/packages/?name=zsh-theme-powerlevel10k)
- powerline-go *(Only for **Manjaro** users)*
- [go](https://archlinux.org/packages/?name=go) *(Only needed for **non-Manjaro** users)*

##### AUR

- [autojump-git](https://aur.archlinux.org/packages/autojump-git/)
- [ttf-meslo-nerd-font-powerlevel10k](https://aur.archlinux.org/packages/ttf-meslo-nerd-font-powerlevel10k/)

### Git repositories
*(These are **NOT** needed for **arch** users - There are already arch packages for them)*
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) *(Powerlevel10k recommended font)*
### Other Packages
#### Cargo
- [exa](https://github.com/ogham/exa) *(Ubuntu 20.04 or earlier)*
#### Go
*(Only needed for **non-Manjaro** users. For **Manjaro** users, check the [pacman packages](#pacman) section.)*
- [powerline-go](https://github.com/justjanne/powerline-go)

### Installation script
#### Ubuntu
```shell
# ---
# Ubuntu 20.04 or earlier
sudo apt install cargo
cargo install exa

# Ubuntu 20.10 or later
sudo apt install exa
# ---

sudo apt install golang-go
go get -v -u github.com/justjanne/powerline-go
sudo apt install autojump neofetch zsh zsh-syntax-highlighting zsh-autosuggestions 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

For the `MesloLGS NF` font, it's probably better to just follow the instructions from the [powerlevel10k README](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k).
#### Arch
*(this script uses `paru` to install AUR packages)*
```shell
sudo pacman -S neofetch exa zsh zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k go
go get -v -u github.com/justjanne/powerline-go
paru -S autojump-git ttf-meslo-nerd-font-powerlevel10k
```

### Change shell to ZSH (optional)
```shell
chsh $USER -s /bin/zsh
```

## How to clone this repo

### Packages needed
This method requires `stow` for creating symlinks and `ed` for custom `.bashrc` support.
#### Ubuntu
```shell
sudo apt install stow ed
```
#### Arch
```shell
sudo pacman -S --needed stow ed
```

### Script
```shell
git clone https://github.com/algono/dotfiles ~/dotfiles

if [ -f ~/.bashrc ]; then mv -f ~/.bashrc ~/dotfiles/bash 
elif [ -f /etc/skel/.bashrc ]; then cp -f /etc/skel/.bashrc ~/dotfiles/bash
fi

if type ed >/dev/null 2>&1 && [ -n $custom_bashrc ]
then
  ed ~/dotfiles/bash/.bashrc < ~/dotfiles/.patches/bashrc-patch.ed
fi

find ~/dotfiles/* -maxdepth 1 -name ".*" -o -type d -prune -printf "%f\n" | xargs /usr/bin/stow -d ~/dotfiles -t ~
```
### Explanation
> Clone repo in dotfiles directory
```shell
git clone https://github.com/algono/dotfiles ~/dotfiles
```
> If there is a custom *.bashrc* (either in the user's personal folder or in the system's *skel* folder), use it as a base instead of the fallback one from the dotfiles
```shell
if [ -f ~/.bashrc ]; then mv -f ~/.bashrc ~/dotfiles/bash 
elif [ -f /etc/skel/.bashrc ]; then cp -f /etc/skel/.bashrc ~/dotfiles/bash
fi
```
> If the *ed* command is available and a custom *.bashrc* was found (it probably was), use the *ed* command to apply the relevant changes to the custom *.bashrc* file (Note: You should backup `~/.bashrc` first if you have that file, as this method has not been extensively tested and it could break it)
```shell
if type ed >/dev/null 2>&1 && [ -n $custom_bashrc ]
then
  ed ~/dotfiles/bash/.bashrc < ~/dotfiles/.patches/bashrc.patch.ed
fi
```
> Create symlinks for our dotfiles into the home directory
> (this command matches all non-hidden directories inside the 'dotfiles' folder)
```shell
find ~/dotfiles/* -maxdepth 1 -name ".*" -o -type d -prune -printf "%f\n" | xargs /usr/bin/stow -d ~/dotfiles -t ~
```

### The last command didn't work. It told me that some files were going to be overwritten and failed.
If you already have some of the files from this repo, the last command will warn you and won't run.

`Stow` does not have any option to overwrite files, so you can either **make backups** of these files *(example: `mv .dotfile .dotfile.bak`)*, or just **delete them**, and then re-run the last command.
