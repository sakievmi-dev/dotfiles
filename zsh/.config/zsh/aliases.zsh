# === GENERAL ===
alias f='clear && fastfetch'				# Simple fetch
alias ff='clear && fastfetch --config none'	# FullFetch
alias e='$EDITOR'
alias v='pulsemixer'
alias lg='lazygit'

alias ls='eza --icons'
alias ll='eza --icons -lha --group-directories-first'
alias tree='eza --icons --tree'

alias pkgs='pacman -Qe'
alias cleano='sudo pacman -Rs $(pacman -Qqdt)'

# === PYTHON ===
alias py='python'
alias venv='source .venv/bin/activate' # Activates Python .venv from root project folder

# === YAZI ===
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# === MISC ===
alias virt-start='sudo chmod 666 /dev/input/by-id/usb-Beken_2.4G_Wireless_Device-if01-event-mouse && sudo chmod 666 /dev/input/by-id/usb-MCHOSE_Jet75-II_2024-04-25-event-kbd && sudo virsh start "win10_roblox-bss-macro"'
alias mchose='sudo chmod 666 /dev/hidraw* && /opt/google/chrome/chrome "https://www.mchose.com.cn/\#/connectDevice"' # Change permission for hidraw devices and opens MCHOSE driver hub
