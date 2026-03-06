#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed cmd-polkit-git fuzzel jq

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ fuzzel --adopt
