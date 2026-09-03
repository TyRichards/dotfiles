-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Open the bound Bitwarden app and btop as standard tiled panes instead of
-- Omarchy's pre-sized floating windows.
o.window("^(Bitwarden|org\\.omarchy\\.btop)$", {
  tile = true,
  tag = "-floating-window",
})

-- Keep Bitwarden's Chromium extension popouts at the size they can render.
-- Remove after the upstream Omarchy fix is installed.
o.window(".*nngceckbapebfimnlniiiahkandclblb.*", {
  float = true,
  max_size = { 480, 650 },
  no_blur = true,
  no_screen_share = true,
})
