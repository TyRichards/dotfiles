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

# Create a Tmux Dev Layout with editor, ai, and terminal
# Usage: tdl <c|cx|codex|other_ai> [<second_ai>]
tdl() {
  [[ -z $1 ]] && { echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tdl."; return 1; }

  local current_dir="${PWD}"
  local editor_pane ai_pane ai2_pane
  local ai="$1"
  local ai2="$2"

  # Use TMUX_PANE for the pane we're running in (stable even if active window changes)
  editor_pane="$TMUX_PANE"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split editor pane horizontally - AI on right ~34% (matches new-tmux layout)
  ai_pane=$(tmux split-window -h -p 34 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  # Split editor pane vertically - terminal on bottom ~10% of left side only
  tmux split-window -v -p 10 -t "$editor_pane" -c "$current_dir"

  # If second AI provided, split the AI pane vertically
  if [[ -n $ai2 ]]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" "$ai2" C-m
  fi

  # Run ai in the right pane
  tmux send-keys -t "$ai_pane" "$ai" C-m

  # Run nvim in the left pane
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m

  # Select the nvim pane for focus
  tmux select-pane -t "$editor_pane"
}

# Create multiple tdl windows with one per subdirectory in the current directory
# Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]
tdlm() {
  [[ -z $1 ]] && { echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tdlm."; return 1; }

  local ai="$1"
  local ai2="$2"
  local base_dir="$PWD"
  local first=true

  # Rename the session to the current directory name (replace dots/colons which tmux disallows)
  tmux rename-session "$(basename "$base_dir" | tr '.:' '--')"

  for dir in "$base_dir"/*/; do
    [[ -d $dir ]] || continue
    local dirpath="${dir%/}"

    if $first; then
      # Reuse the current window for the first project
      tmux send-keys -t "$TMUX_PANE" "cd '$dirpath' && tdl $ai $ai2" C-m
      first=false
    else
      local pane_id=$(tmux new-window -c "$dirpath" -P -F '#{pane_id}')
      tmux send-keys -t "$pane_id" "tdl $ai $ai2" C-m
    fi
  done
}

# Create a multi-pane swarm layout with the same command started in each pane (great for AI)
# Usage: tsl <pane_count> <command>
tsl() {
  [[ -z $1 || -z $2 ]] && { echo "Usage: tsl <pane_count> <command>"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tsl."; return 1; }

  local count="$1"
  local cmd="$2"
  local current_dir="${PWD}"
  local -a panes

  tmux rename-window -t "$TMUX_PANE" "$(basename "$current_dir")"

  panes+=("$TMUX_PANE")

  while (( ${#panes[@]} < count )); do
    local new_pane
    local split_target="${panes[-1]}"
    new_pane=$(tmux split-window -h -t "$split_target" -c "$current_dir" -P -F '#{pane_id}')
    panes+=("$new_pane")
    tmux select-layout -t "${panes[0]}" tiled
  done

  for pane in "${panes[@]}"; do
    tmux send-keys -t "$pane" "$cmd" C-m
  done

  tmux select-pane -t "${panes[0]}"
}

export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$HOME/.local/bin:$PATH"
export XDG_SESSION_TYPE=wayland

# export QT_SCALE_FACTOR=0.75
export PATH="$HOME/.npm-global/bin:$PATH"
