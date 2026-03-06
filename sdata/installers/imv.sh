#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed imv

# Stow package
cd ~/.dotfiles/pkgs/extra
stow -R -t ~ imv --adopt
