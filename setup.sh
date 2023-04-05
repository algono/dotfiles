#!/bin/sh

git clone https://github.com/algono/dotfiles ~/dotfiles

if [ -f ~/.bashrc ]; then mv -f ~/.bashrc ~/dotfiles/bash
elif [ -f /etc/skel/.bashrc ]; then cp -f /etc/skel/.bashrc ~/dotfiles/bash
elif uname -r | grep -iq manjaro; then cp ~/dotfiles/.bash-presets/.bashrc-manjaro ~/dotfiles/bash/.bashrc
else cp ~/dotfiles/.bash-presets/.bashrc-wsl ~/dotfiles/bash/.bashrc
fi

[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak

ed ~/dotfiles/bash/.bashrc < ~/dotfiles/.patches/bashrc-patch.ed

find ~/dotfiles/* -maxdepth 1 -name ".*" -o -type d -prune -printf "%f\n" | xargs /usr/bin/stow -d ~/dotfiles -t ~
