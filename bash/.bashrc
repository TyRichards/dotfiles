source ~/.local/share/omarchy/default/bash/rc

# git shortcuts
alias st='git status'
alias add='git add .'
alias commit='git commit -am'
alias push='git push'
alias pull='git pull'

#dotfile shortcuts
alias dot='cd ~/dotfiles/'
alias dot-bindings='n ~/dotfiles/hyprland/.config/hypr/bindings.conf'
alias dot-input='n ~/dotfiles/hyprland/.config/hypr/input.conf'
alias dot-envs='n ~/.config/hypr/envs.conf'
alias dot-hyprland='n ~/dotfiles/hyprland/.config/hypr/hyprland.conf'
alias dot-alacritty='n ~/dotfiles/alacritty/.config/alacritty/alacritty.toml'
alias dot-waybar='n ~/dotfiles/waybar/.config/waybar/config.jsonc'
alias dot-waybar-style='n ~/dotfiles/waybar/.config/waybar/style.css'
alias dot-bash='n ~/dotfiles/bash/.bashrc'
alias dot-gtk='nwg-look' # OR n ~/.config/gtk-3.0/settings.ini
alias dot-rmpc='n ~/dotfiles/rmpc/.config/rmpc/config.ron'
alias dot-mpd='n ~/dotfiles/mpd/.config/mpd/mpd.conf'
alias dot-nvim='n ~/dotfiles/nvim/.config/nvim/'

#themes
alias theme='cd ~/.config/omarchy/themes/'
alias theme-space-monkey='cd ~/.config/omarchy/themes/space-monkey/'
alias theme-felix='cd ~/.config/omarchy/themes/felix/'
alias theme-super-game-bro='cd ~/.config/omarchy/themes/super-game-bro/'

export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$HOME/.local/bin:$PATH"
export XDG_SESSION_TYPE=wayland

# export QT_SCALE_FACTOR=0.75
