#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed fastfetch

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ fastfetch --adopt
