source ~/.local/share/omarchy/default/bash/rc

# git shortcuts
alias st='git status'
alias add='git add .'
alias commit='git commit -am'
alias push='git push'
alias pull='git pull'

#dotfile shortcuts
alias dot='cd ~/dotfiles/'
alias dot-hyprland='n ~/dotfiles/hyprland/.config/hypr/hyprland.conf'
alias dot-alacritty='n ~/dotfiles/alacritty/.config/alacritty/alacritty.toml'
alias dot-waybar='n ~/dotfiles/waybar/.config/waybar/config.jsonc'
alias dot-waybar-style='n ~/dotfiles/waybar/.config/waybar/style.css'
alias dot-bash='n ~/dotfiles/bash/.bashrc'
alias dot-gtk='nwg-look' # OR n ~/.config/gtk-3.0/settings.ini

export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$HOME/.local/bin:$PATH"
export XDG_SESSION_TYPE=wayland
