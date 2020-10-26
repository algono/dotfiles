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

### Instalation script
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
### Script
```shell
git clone --bare https://github.com/algono/dotfiles $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.sparsecheckout true
echo '/*
!README.md
' > $HOME/.dotfiles/info/sparse-checkout
dotfiles checkout
```
### Explanation
> Clone bare repo in dotfiles directory, without getting its contents
```shell
git clone --bare https://github.com/algono/dotfiles $HOME/.dotfiles
```
> Create 'dotfiles' alias to make the following commands shorter and easier to understand
```shell
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```
> Don't show untracked files when doing commands like `status` (being your home directory, there will probably be *a lot*)
```shell
dotfiles config --local status.showUntrackedFiles no
```
> Prevent this readme file from being checked out into your home directory
```shell
dotfiles config --local core.sparsecheckout true
echo '/*
!README.md
' > $HOME/.dotfiles/info/sparse-checkout
```
> Checkout the actual dotfiles into the home directory
```shell
dotfiles checkout
```

#### The last command didn't work. It told me that some files were going to be overwritten and failed.
If you already have some of the files from this repo, the last command will warn you and won't run.
Here are some possible solutions to that:
- **Overwrite** all matching files with the ones from this repo:
```shell
dotfiles reset --hard
```
- Make backups of these files *(example: `mv .dotfile .dotfile.bak`)*, then re-run the last command.
