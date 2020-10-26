# Dotfiles
My dotfiles for **Ubuntu**

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
go get -u github.com/justjanne/powerline-go
sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions autojump neofetch
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```
#### Bash only
```shell
sudo apt install cargo
cargo install exa
sudo apt install golang-go
go get -u github.com/justjanne/powerline-go
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
This method requires `stow`. You can install it as any other apt package.

### Script
```shell
git clone https://github.com/algono/dotfiles $HOME/dotfiles
stow -d ~/dotfiles/packages -t ~ *
```
### Explanation
> Clone repo in dotfiles directory
```shell
git clone https://github.com/algono/dotfiles $HOME/dotfiles
```
> Create symlinks for our dotfiles into the home directory
```shell
stow -d ~/dotfiles/packages -t ~ *
```

### The last command didn't work. It told me that some files were going to be overwritten and failed.
If you already have some of the files from this repo, the last command will warn you and won't run.

`Stow` does not have any option to overwrite files, so you can either **make backups** of these files *(example: `mv .dotfile .dotfile.bak`)*, or just **delete them**, and then re-run the last command.
