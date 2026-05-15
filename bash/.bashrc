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
alias dot-ghostty='n ~/dotfiles/ghostty/.config/ghostty/config'
alias dot-kitty='n ~/dotfiles/kitty/.config/kitty/kitty.conf'
alias dot-alacritty='n ~/dotfiles/alacritty/.config/alacritty/alacritty.toml'
alias dot-waybar='n ~/dotfiles/waybar/.config/waybar/config.jsonc'
alias dot-waybar-style='n ~/dotfiles/waybar/.config/waybar/style.css'
alias dot-bash='n ~/dotfiles/bash/.bashrc'
alias dot-gtk='nwg-look' # OR n ~/.config/gtk-3.0/settings.ini
alias dot-rmpc='n ~/dotfiles/rmpc/.config/rmpc/config.ron'
alias dot-mpd='n ~/dotfiles/mpd/.config/mpd/mpd.conf'
alias dot-nvim='n ~/dotfiles/nvim/.config/nvim/'
alias dot-hyprlock='n ~/dotfiles/hyprland/.config/hypr/hyprlock.conf'
alias dot-tmux='n ~/dotfiles/tmux/.config/tmux/tmux.conf'

# Omarchy Themes
alias theme='cd ~/.config/omarchy/themes/'
alias theme-space-monkey='cd ~/.config/omarchy/themes/space-monkey/'
alias theme-felix='cd ~/.config/omarchy/themes/felix/'
alias theme-super-game-bro='cd ~/.config/omarchy/themes/super-game-bro/'
alias theme-odyssey='cd ~/.config/omarchy/themes/odyssey'
alias theme-framework='cd ~/.config/omarchy/themes/framework'

# Projects
alias pi-x='cd ~/dev/oss/pi-experiments'

# try-cli shell integration disabled.
# Omarchy defines a lazy `try()` wrapper in its default bash init; remove it so opening a terminal
# does not auto-load/init try-cli behavior. The `try` binary remains available on PATH.
# unset -f try 2>/dev/null || true
# Re-enable if you want `try` to cd into selected experiment dirs automatically.
# eval "$(try init)"


# SSH to Machines
alias ssh-claw='ssh claw@beelink.tail6c9375.ts.net'

# Pi profiles
alias pi-pdx='PI_CODING_AGENT_DIR=$HOME/.pi-paradox/agent pi'
alias pi-xam='PI_CODING_AGENT_DIR=$HOME/.pi-xammis/agent pi'

# Connect to OpenClaw background ssh & Connect to OpenClaw TUI remotely
claw() {
  local local_port=28789
  local remote_port=18789
  local host="claw@beelink.tail6c9375.ts.net"
  local sock="${TMPDIR:-/tmp}/claw-openclaw.sock"
  local token

  token="$(< ~/.config/openclaw/gateway-token)" || {
    echo "Could not read ~/.config/openclaw/gateway-token"
    return 1
  }

  # Kill prior control-master tunnel if it exists
  ssh -S "$sock" -O exit "$host" >/dev/null 2>&1 || true
  rm -f "$sock"

  # If something is already listening on the chosen local port, bail clearly
  if lsof -tiTCP:"$local_port" -sTCP:LISTEN >/dev/null 2>&1; then
    echo "Local port $local_port is already in use:"
    lsof -nP -iTCP:"$local_port" -sTCP:LISTEN
    return 1
  fi

  ssh -f -n -N -T \
    -o ExitOnForwardFailure=yes \
    -o ServerAliveInterval=60 \
    -o ServerAliveCountMax=3 \
    -o ControlMaster=yes \
    -o ControlPath="$sock" \
    -L "${local_port}:127.0.0.1:${remote_port}" \
    "$host" || return 1

  cleanup() {
    ssh -S "$sock" -O exit "$host" >/dev/null 2>&1 || true
    rm -f "$sock"
  }

  trap cleanup EXIT INT TERM

  openclaw tui \
    --url "ws://127.0.0.1:${local_port}" \
    --token "$token" \
    --session main

  local rc=$?
  cleanup
  trap - EXIT INT TERM
  return $rc
}

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

# Singular Pi chat
alias chat='pi --model openrouter/openai/gpt-5.5 --thinking low'

# Private space workspace
space() {
  cd "$HOME/dev/oss/space" || return
  local hephaestus="$HOME/dev/oss/space/.pi/npm/node_modules/pi-ui-hephaestus/src/index.ts"
  pi \
    --no-session \
    --no-context-files \
    --no-skills \
    --no-extensions \
    --extension "$hephaestus" \
    --no-prompt-templates \
    --no-tools \
    --model openrouter/openai/gpt-5.5 \
    --thinking medium \
    --system-prompt "$(cat "$HOME/dev/oss/space/AGENTS.md")"
}

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
export PATH="$HOME/.npm-global/bin:$PATH"
