#!/bin/bash
yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed mpv

# Stow package
cd ~/.dotfiles/pkgs/extra
stow -R -t ~ mpv --adopt
