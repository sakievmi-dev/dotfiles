#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed kitty

# Stow package
cd ~/.dotfiles/pkgs
stow -R -t ~ core/kitty --adopt
