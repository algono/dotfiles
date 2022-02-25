#!/bin/sh

git clone https://github.com/algono/dotfiles ~/dotfiles

if [ -f ~/.bashrc ]; then mv -f ~/.bashrc ~/dotfiles/bash
elif [ -f /etc/skel/.bashrc ]; then cp -f /etc/skel/.bashrc ~/dotfiles/bash
elif uname -r | grep -iq manjaro; then cp ~/dotfiles/bash/.bashrc-manjaro ~/dotfiles/bash/.bashrc
else cp ~/dotfiles/bash/.bashrc-wsl ~/dotfiles/bash/.bashrc
fi

[ -f ~/.zshrc ] && rm ~/.zshrc

ed ~/dotfiles/bash/.bashrc < ~/dotfiles/.patches/bashrc-patch.ed

grep -qF ". ~/.bash_aliases" ~/dotfiles/bash/.bashrc || (echo -e '\n[ -f ~/.bash_aliases ] && . ~/.bash_aliases\n' >> ~/dotfiles/bash/.bashrc)

find ~/dotfiles/* -maxdepth 1 -name ".*" -o -type d -prune -printf "%f\n" | xargs /usr/bin/stow -d ~/dotfiles -t ~
