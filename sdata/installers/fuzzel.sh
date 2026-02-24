yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed cmd-polkit-git fuzzel jq

# Stow package
cd ~/.dotfiles/pkgs
stow -R -t ~ core/fuzzel --adopt
