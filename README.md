# Dotfiles
My dotfiles for **Ubuntu**

## Dependencies
### Packages
- zsh
- zsh-syntax-highlighting
- zsh-autosuggestions
- autojump
- neofetch
### Git repos
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)

### Instalation script
```shell
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
' > $HOME/.dotfiles/.git/info/sparse-checkout
dotfiles pull
```
### Explanation
> Clone bare repo in dotfiles directory, without getting its contents
```shell
git clone --bare https://github.com/algono/dotfiles $HOME/.dotfiles
```
> (Only for the current session) Create dotfiles alias to make the following commands shorter and easier to understand
```shell
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```
> Don't show untracked files when doing commands like `status` (being your home directory, there will probably be *a lot*)
```shell
dotfiles config --local status.showUntrackedFiles no
```
> Prevent this readme file being checked out into your home directory
```shell
dotfiles config --local core.sparsecheckout true
echo '/*
!README.md
' > $HOME/.dotfiles/.git/info/sparse-checkout
```
> Pull the actual dotfiles into the home directory
```shell
dotfiles pull
```
