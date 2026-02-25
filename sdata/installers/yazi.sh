yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed xdg-desktop-portal-termfilechooser-hunkyburrito-git yazi

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ yazi --adopt
