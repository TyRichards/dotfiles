# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

source ~/.local/share/omarchy/default/bash/rc

# git shortcuts
alias st='git status'
alias add='git add .'
alias commit='git commit -am'
alias push='git push'
alias pull='git pull'

# dotfile shortcuts
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
alias dot-hyprlock='n ~/dotfiles/hyprland/.config/hypr/hyprlock.conf'

# Omarchy Themes
alias theme='cd ~/.config/omarchy/themes/'
alias theme-space-monkey='cd ~/.config/omarchy/themes/space-monkey/'
alias theme-felix='cd ~/.config/omarchy/themes/felix/'
alias theme-super-game-bro='cd ~/.config/omarchy/themes/super-game-bro/'

# SSH WP Engine Websites
alias ssh-fl='ssh fuellogicweb@fuellogicweb.ssh.wpengine.net'
alias ssh-fl-dev='ssh fuellogicdev@fuellogicdev.ssh.wpengine.net'
alias ssh-rh='ssh rhinofuel@rhinofuel.ssh.wpengine.net'
alias ssh-rh-dev='ssh rhinofueldevel@.ssh.wpengine.net'
alias ssh-fc='ssh fuelcoreprod@fuelcoreprod.ssh.wpengine.net'
alias ssh-fc-dev='ssh devfuelcore@devfuelcore.ssh.wpengine.net'
alias ssh-tf='ssh tecfuel@tecfuel.ssh.wpengine.net'
alias ssh-tf-dev='ssh tecfueldev@tecfueldev.ssh.wpengine.net'
alias ssh-fm='ssh fuelmonkey@fuelmonkey.ssh.wpengine.net'
alias ssh-ty='ssh tyrichards@tyrichards.ssh.wpengine.net'
# alias ssh-fm-dev='ssh fuelmonkeydev@fuelmonkeydev.ssh.wpengine.net'

# Music Management
alias update-shuffle='python /usr/bin/ipod-shuffle-4g /run/media/trr/TYPOD/ --track-voiceover'

download() {
    yt-dlp -x \
        --audio-format mp3 \
        --audio-quality 0 \
        --embed-thumbnail \
        --embed-metadata \
        --parse-metadata "playlist_index:%(track_number)s" \
        -o "%(playlist_index)02d %(title)s.%(ext)s" \
        "$@"
}

export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$HOME/.local/bin:$PATH"
export XDG_SESSION_TYPE=wayland

# export QT_SCALE_FACTOR=0.75
