# 📦 My .dotfiles
This is my personal easy-to-install .dotfiles with _pretty much_ pre-configured environment.
### "Philosophy" behind my .dotfiles
I like the workflow of modern wayland compositors, but everyone (for some reason) wants these ugly rounded corners. I tried to make my configs as simple as possible to avoid any rounded elements.

And also i tried to use p10k style everywhere i could. It's just looks cool to me; there is nothing serious behind this decision.
### ⚠️ NOT A "USABILITY-FIRST" ⚠️
If you like my configs and want to use them, just fork my project and make changes for yourself. **I don't guarantee that my dots will work out of the box.**

But anyway, I accept any kind of help if you want to contribute.
### Stack
- **OS:** Arch Linux
- **WM (Compositor):** Niri
- **Shell:** zsh
- **Terminal:** kitty
- **Launcher:** fuzzel
# 🔃 Quick setup
1. Install requirements
```
sudo pacman -Syu stow
```
2. Clone this repository with this command:
```bash
git clone https://github.com/sakievmi-dev/dotfiles.git ~/.dotfiles
```
3. Run setup script in cloned repository
```bash
~/.dotfiles/setup.py setup
```
4. Optionally, but you can install additional packages
```bash
~/.dotfiles/setup.py install imv mpv
```
