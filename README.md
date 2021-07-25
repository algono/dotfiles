# Dotfiles
My dotfiles, originally designed for **Ubuntu (WSL 2)**

## Dependencies
### Packages (apt)
- autojump
- neofetch
#### ZSH only
- zsh
- zsh-syntax-highlighting
- zsh-autosuggestions
### Git repos
#### ZSH only
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
### Other
- exa (requires 'cargo' apt package)
#### Bash only
- powerline-go (requires 'golang-go' apt package)

### Installation script
#### Everything
```shell
sudo apt install cargo
cargo install exa
sudo apt install golang-go
go get -v -u github.com/justjanne/powerline-go
sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions autojump neofetch
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```
#### Bash only
```shell
sudo apt install cargo
cargo install exa
sudo apt install golang-go
go get -v -u github.com/justjanne/powerline-go
sudo apt install autojump neofetch
```
#### ZSH only
```shell
sudo apt install cargo
cargo install exa
sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions autojump neofetch
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

### Change shell to ZSH (optional)
```shell
chsh $USER
```
Then type `/bin/zsh`

## How to clone this repo

### Packages needed
This method requires `stow` for creating symlinks and `ed` for custom `.bashrc` support.
#### Ubuntu
```shell
sudo apt install stow ed
```
#### Arch
```shell
sudo pacman -S stow ed
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
