#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed ttf-twemoji-color bibata-cursor-theme niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk noto-fonts noto-fonts-cjk swww ttf-jetbrains-mono-nerd

# Icons
mkdir -p ~/.local/share/icons/
cd ~/.local/share/icons/

git clone https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git yamis

# Stow package
cd ~/.dotfiles/pkgs
stow -R -t ~ core/niri --adopt
