#!/bin/sh

# Install pacman packages
sudo pacman -Sy && \
  sudo pacman -S --noconfirm --needed \
    eza \
    zoxide \
    bat \
    neofetch \
    zsh \
    zsh-syntax-highlighting zsh-autosuggestions \
    zsh-theme-powerlevel10k \
    stow ed

# This helper function tries to use paru as AUR helper.
# If paru is not available or the command fails, it tries to use yay as fallback.
# And if yay is not available either, it skips the command.
_aur_helper() {
  if type paru >/dev/null 2>&1; then paru "$@" && return; fi
  if type yay >/dev/null 2>&1; then yay "$@"
  else echo "No AUR helper was found. Skipping..."
  fi
}

# Install AUR packages
_aur_helper -S --noconfirm --needed \
  ttf-meslo-nerd-font-powerlevel10k
