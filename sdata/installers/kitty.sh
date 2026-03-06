#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed kitty

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ kitty --adopt
