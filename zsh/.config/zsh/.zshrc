export PATH="$PATH:/home/sakievmi/.local/bin"

ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"; mkdir -p ~/.cache/zsh
ZSH=/usr/share/oh-my-zsh/

plugins=(
    git
    extract
)

source $ZSH/oh-my-zsh.sh

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/keybinds.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if [[ -o interactive && -z "$NVIM" && -z "$VIMRUNTIME" ]]; then
    fastfetch
fi
