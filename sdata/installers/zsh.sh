yay --diffmenu=false --cleanmenu=false --editmenu=false -S --noconfirm --needed oh-my-zsh-git zsh-vi-mode zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting

# Stow package
cd ~/.dotfiles/pkgs/core
stow -R -t ~ zsh --adopt
