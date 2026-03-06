yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed neovim

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ nvim --adopt
