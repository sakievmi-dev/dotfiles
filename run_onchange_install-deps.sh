#/usr/bin/env sh
PACKAGES=(
    # ZSH
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    zsh-vi-mode

    # Yazi
    yazi
    unzip

    # WM (Niri)
    niri
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
    waybar
    dunst
    fuzzel
    ttf-twemoji-color
    otf-geist-mono-nerd
    foot
)

yay --needed -S "${PACKAGES[@]}"
