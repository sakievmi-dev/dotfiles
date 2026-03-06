#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed dunst

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ dunst --adopt
