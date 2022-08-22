#!/bin/sh

# Install apt packages (that don't depend on the version)
sudo apt-get update && \
  sudo apt-get -y install --no-install-recommends \
    bat \
    golang-go \
    neofetch \
    zsh zsh-syntax-highlighting zsh-autosuggestions \
    stow ed

# Install powerline-go (prompt for bash)
go install github.com/justjanne/powerline-go@latest

# Install powerlevel10k (prompt for zsh)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Installing version-dependent packages

# Source variables related to Ubuntu version
# ("$DISTRIB_RELEASE" gets the version)
. /etc/lsb-release

# Ubuntu 20.10 or later?
if (dpkg --compare-versions "$DISTRIB_RELEASE" "ge" "20.10")
then
  sudo apt-get -y install --no-install-recommends exa
else
  sudo apt-get -y install --no-install-recommends cargo
  cargo install exa
fi

# Ubuntu 21.04 or later?
if (dpkg --compare-versions "$DISTRIB_RELEASE" "ge" "21.04")
then
  sudo apt-get -y install --no-install-recommends zoxide
else
  sudo apt-get -y install --no-install-recommends autojump
fi
