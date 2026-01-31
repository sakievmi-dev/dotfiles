#!/usr/bin/env bash
LOG_FILE="install.log"
> "$LOG_FILE"

echo "Administrator privileges required..."
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install all dependencies
gum spin --spinner dot --title "Updating system..." -- bash -c "sudo pacman -Syu --noconfirm >> '$LOG_FILE' 2>&1"
gum spin --spinner dot --title "Installing base dependencies..." -- bash -c "sudo pacman -S --needed --noconfirm base-devel git stow gum >> '$LOG_FILE' 2>&1"

# Install yay if not found
install_yay() {
    YAY_TMP=$(mktemp -d)

    git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$YAY_TMP" > /dev/null 2>&1

    cd "$YAY_TMP" || return 1

    makepkg -si --noconfirm

    cd - > /dev/null
    rm -rf "$YAY_TMP"

}

if ! command -v yay &> /dev/null; then
    echo "yay not found. Starting installation..."
    
    if install_yay >> "$LOG_FILE" 2>&1; then
        echo "yay installed successfully!"
    else
        echo "yay installation FAILED. Check $LOG_FILE"
        exit 1
    fi
fi

choices=()
for d in */; do
    pkg=${d%/}
    [[ "$pkg" == .* ]] && continue
    desc=$(head -n 1 "$pkg/info.txt" 2>/dev/null || echo "No description")
    choices+=("$pkg | $desc")
done

selected=$(printf "%s\n" "${choices[@]}" | gum choose --no-limit --header="Select packages" --height=15)
[ -z "$selected" ] && exit 0

echo "$selected" | while read -r line; do
    package=$(echo "$line" | awk -F ' | ' '{print $1}')

    if gum spin --spinner dot --title "Installing $package (check $LOG_FILE for details)..." -- bash -c "
        set -e
        # 1. PREINSTALL
        if [[ -f '$package/preinstall.sh' ]]; then
            chmod +x '$package/preinstall.sh'
            ./'$package/preinstall.sh' >> '$LOG_FILE' 2>&1
        fi

        # 2. STOW
        stow -R --ignore="info.txt" --ignore="preinstall.sh" --ignore="postinstall.sh" '$package' --adopt >> '$LOG_FILE' 2>&1

        # 3. POSTINSTALL
        if [[ -f '$package/postinstall.sh' ]]; then
            chmod +x '$package/postinstall.sh'
            ./'$package/postinstall.sh' >> '$LOG_FILE' 2>&1
        fi
    "; then
        echo "$package: Done"
    else
        echo "$package: FAILED. See $LOG_FILE for details."
        if gum confirm "Show error log for $package?"; then
            gum pager < "$LOG_FILE"
        fi
    fi
done

gum style --foreground 2 --border-foreground 2 --border double --align center --width 50 --margin "1 2" --padding "1 2" "Installation Complete!"
