yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed waybar ttf-jetbrains-mono-nerd waybar-updates

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ waybar --adopt
