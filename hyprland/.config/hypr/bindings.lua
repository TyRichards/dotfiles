-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Bindings ported from dotfiles_2025 hyprland/.config/hypr/bindings.conf.
-- These are rewritten for Omarchy Quattro's Hyprland Lua config. Bindings that
-- collide with current Quattro defaults are left commented in the section below.

-- Apps, web apps, and TUIs
o.bind("SUPER + SHIFT + CTRL + F", "Yazi", { tui = "yazi" })
o.bind("SUPER + SHIFT + CTRL + T", "Activity", { tui = "btop" })
o.bind("SUPER + SHIFT + ALT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + ALT + S", "Omaski", "omarchy shell omaski launch")
o.bind("F10", "ChatGPT", { webapp = "https://chatgpt.com/" })
o.bind("code:255", "AI", { webapp = "https://chatgpt.com/" })
o.bind("XF86Search", "AI", { webapp = "https://chatgpt.com/" })
o.bind("SUPER + SHIFT + CTRL + M", "YouTube Music", { webapp = "https://music.youtube.com/" })
o.bind("SUPER + SHIFT + K", "KVM", { webapp = "https://kvm/" })
o.bind("SUPER + SHIFT + CTRL + ALT + M", "Bandcamp", { webapp = "https://bandcamp.com/tyrichards" })
o.bind("SUPER + SHIFT + CTRL + O", "Sprinter", { webapp = "https://sprinter.getfreewrite.com/" })
o.bind("SUPER + SHIFT + ALT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
o.bind("SUPER + SHIFT + CTRL + Y", "YNAB", { webapp = "https://app.ynab.com/0e1590a0-5d83-4f73-9eb9-ec7a73224660/accounts/0fb9be55-928c-4656-bccf-2cb841f9730c" })
o.bind("SUPER + SHIFT + ALT + Y", "Netflix", { webapp = "https://www.netflix.com/browse" })
o.bind("SUPER + SHIFT + CTRL + X", "X Post", { webapp = "https://x.com/compose/post" })
o.bind("SUPER + SHIFT + CTRL + S", "Strety", { webapp = "https://2.strety.com/171dc201-25de-40db-86c9-0817d43a6ab7/home" })
o.bind("SUPER + SHIFT + ALT + R", "Basecamp Heystack", { webapp = "https://3.basecamp.com/5973641/my/readings" })
o.bind("SUPER + SHIFT + Z", "RingCentral", { webapp = "https://v.ringcentral.com/launcher/524419047" })
o.bind("SUPER + SHIFT + L", "Light Phone", { webapp = "https://dashboard.thelightphone.com/devices/bebe5ada-a6e4-417f-b40a-e9274cc60005" })
o.bind("SUPER + SHIFT + I", "Canva", { webapp = "https://www.canva.com/projects/your-projects" })
o.bind("SUPER + SHIFT + CTRL + I", "Photoshop", { launch = "chromium --app=https://photoshop.adobe.com/?tab=cloud-documents --ozone-platform=wayland" })
o.bind("SUPER + SHIFT + ALT + I", "Lightroom", { launch = "chromium --app=https://lightroom.adobe.com/home --ozone-platform=wayland" })
o.bind("SUPER + SHIFT + V", "Capcut", { webapp = "https://www.capcut.com/my-cloud/7552741030714671165" })

-- OMARCHY QUATTRO OVERRIDES
--
-- Free these group-movement shortcuts for Brave.
hl.unbind("SUPER + ALT + LEFT")
hl.unbind("SUPER + ALT + RIGHT")

-- Rebind SUPER+SHIFT+ALT+M from Quattro's Music TUI binding to Jellyfin.
hl.unbind("SUPER + SHIFT + ALT + M")
o.bind("SUPER + SHIFT + ALT + M", "Jellyfin", { webapp = "http://media.catknife.com" })

-- Rebind SUPER+SHIFT+SLASH from Quattro's 1Password binding to Bitwarden.
hl.unbind("SUPER + SHIFT + SLASH")
o.bind("SUPER + SHIFT + SLASH", "Bitwarden", { launch = "bitwarden-desktop", focus = "Bitwarden" })

-- Rebind SUPER+SHIFT+M from Quattro's Music binding to Cliamp.
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Cliamp", { tui = "cliamp" })

-- Rebind SUPER+TAB from Quattro's Next workspace binding to last used workspace.
hl.unbind("SUPER + TAB")
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }), { description = "Last used workspace" })

-- Rebind SUPER+SHIFT+G from Quattro's Signal binding to Google Maps.
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Google Maps", { webapp = "https://maps.google.com/", focus = true })

-- Rebind SUPER+SHIFT+S from Quattro's Google Maps binding to Basecamp.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Basecamp", { webapp = "https://3.basecamp.com/5973641/" })

-- Rebind SUPER+SHIFT+C from Quattro's HEY Calendar binding to Omacalc.
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Omacalc", "omacalc")

-- System, window, and hardware controls
hl.bind("ALT + SHIFT + UP", hl.dsp.window.move({ into_group = "u" }), { description = "Move window to group on top" })
hl.bind("ALT + SHIFT + DOWN", hl.dsp.window.move({ into_group = "d" }), { description = "Move window to group on bottom" })
o.bind("SUPER + F11", "CRUA HDMI 1", "~/.local/bin/omarchy-crua-input hdmi1")
o.bind("SUPER + F12", "CRUA DP 1", "~/.local/bin/omarchy-crua-input dp1")
o.bind("code:127", "Start Dictation (LG Keyboard)", "voxtype record toggle")
o.bind("XF86AudioMedia", "Start Dictation", "voxtype record toggle")

-- CRT scanlines: toggle power without changing the saved Light/Heavy preset.
-- The minus key is the scanline itself.
--
-- SUPER+CTRL+MINUS was Quattro's "Expand window left a lot". It is declared
-- upstream as `code:20` rather than `MINUS`
-- (default/hypr/bindings/tiling.lua), and hl.unbind matches on the literal
-- key spec — unbinding "SUPER + CTRL + MINUS" silently does nothing. Unbind
-- the keycode form to actually clear it.
hl.unbind("SUPER + CTRL + code:20")
o.bind("SUPER + CTRL + code:20", "Toggle CRT scanlines", "omarchy-shell -q display-scanlines crt toggle")

-- need new keybindings that do not conflict with Quattro
-- The old bindings below conflict with current Omarchy Quattro defaults or with
-- another old binding using the same key. They are preserved here as Lua, but
-- intentionally commented out so they do not override Quattro.


-- SUPER + SHIFT + CTRL + A conflicts with Quattro: Agent.
-- o.bind("SUPER + SHIFT + CTRL + A", "ChatGPT", { webapp = "https://chatgpt.com/" })

-- SUPER + SHIFT + ALT + A conflicts with Quattro: Grok.
-- o.bind("SUPER + SHIFT + ALT + A", "Claude", { webapp = "https://claude.ai/new" })

-- SUPER + SHIFT + A conflicts with Quattro: ChatGPT.
-- o.bind("SUPER + SHIFT + A", "AI Chat (Pi)", "[float; size 600 800; center] uwsm-app -- xdg-terminal-exec --app-id=org.omarchy.chat -e bash -ic chat")

-- SUPER + SHIFT + C was resolved above by unbinding Quattro's HEY Calendar binding before adding Omacalc.

-- SUPER + SHIFT + E conflicts with Quattro: Email.
-- o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://app.hey.com" })

-- SUPER + SHIFT + Y conflicts with Quattro: YouTube.
-- o.bind("SUPER + SHIFT + Y", "YNAB", { webapp = "https://app.ynab.com/0e1590a0-5d83-4f73-9eb9-ec7a73224660/accounts/0fb9be55-928c-4656-bccf-2cb841f9730c" })

-- SUPER + SHIFT + X conflicts with Quattro: X.
-- o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })

-- SUPER + SHIFT + D conflicts with Quattro: Docker.
-- o.bind("SUPER + SHIFT + D", "Discord", { webapp = "https://discord.com/channels/@me" })

-- SUPER + SHIFT + G was resolved above by unbinding Quattro's Signal binding before adding Google Maps.

-- SUPER + SHIFT + S was resolved above by unbinding Quattro's Google Maps binding before adding Basecamp.

-- SUPER + SHIFT + P conflicts with Quattro: Google Photos.
-- o.bind("SUPER + SHIFT + P", "Immich", { webapp = "http://photos.catknife.com" })

-- SUPER + MINUS conflicts with Quattro: Expand window left.
-- hl.bind("SUPER + code:20", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { description = "Expand window left" })

-- SUPER + EQUAL conflicts with Quattro: Shrink window left.
-- hl.bind("SUPER + code:21", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { description = "Shrink window left" })

-- SUPER + SHIFT + MINUS conflicts with Quattro: Shrink window up.
-- hl.bind("SUPER + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { description = "Shrink window up" })

-- SUPER + SHIFT + EQUAL conflicts with Quattro: Expand window down.
-- hl.bind("SUPER + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { description = "Expand window down" })

-- SUPER + CTRL + RIGHT conflicts with Quattro: Move grouped window focus right.
-- hl.bind("SUPER + CTRL + RIGHT", hl.dsp.focus({ workspace = "+1" }), { description = "Next workspace" })

-- SUPER + CTRL + LEFT conflicts with Quattro: Move grouped window focus left.
-- hl.bind("SUPER + CTRL + LEFT", hl.dsp.focus({ workspace = "-1" }), { description = "Previous workspace" })

-- ALT + TAB conflicts with Quattro: Focus on next window / Reveal active window on top.
-- hl.bind("ALT + TAB", hl.dsp.exec_raw("focuscurrentorlast"), { description = "Focus current or last window" })

-- ALT + SHIFT + LEFT conflicts with another old binding above that used the same key for moving windows into groups.
-- hl.bind("ALT + SHIFT + LEFT", hl.dsp.window.move({ into_group = "l" }), { description = "Move window to group on left" })
-- hl.bind("ALT + SHIFT + LEFT", hl.dsp.group.move_window("b"), { description = "Move group window backward" })

-- ALT + SHIFT + RIGHT conflicts with another old binding above that used the same key for moving windows into groups.
-- hl.bind("ALT + SHIFT + RIGHT", hl.dsp.window.move({ into_group = "r" }), { description = "Move window to group on right" })
-- hl.bind("ALT + SHIFT + RIGHT", hl.dsp.group.move_window("f"), { description = "Move group window forward" })

-- XF86MonBrightnessUp conflicts with Quattro: Brightness up.
-- o.bind("XF86MonBrightnessUp", "Brightness up", "~/.local/bin/omarchy-brightness-display +5%", { locked = true, repeating = true })

-- XF86MonBrightnessDown conflicts with Quattro: Brightness down.
-- o.bind("XF86MonBrightnessDown", "Brightness down", "~/.local/bin/omarchy-brightness-display 5%-", { locked = true, repeating = true })

-- SHIFT + XF86MonBrightnessUp conflicts with Quattro: Brightness maximum.
-- o.bind("SHIFT + XF86MonBrightnessUp", "Brightness maximum", "~/.local/bin/omarchy-brightness-display 100%", { locked = true, repeating = true })

-- SHIFT + XF86MonBrightnessDown conflicts with Quattro: Brightness minimum.
-- o.bind("SHIFT + XF86MonBrightnessDown", "Brightness minimum", "~/.local/bin/omarchy-brightness-display 1%", { locked = true, repeating = true })

-- ALT + XF86MonBrightnessUp conflicts with Quattro: Brightness up precise.
-- o.bind("ALT + XF86MonBrightnessUp", "Brightness up precise", "~/.local/bin/omarchy-brightness-display +1%", { locked = true, repeating = true })

-- ALT + XF86MonBrightnessDown conflicts with Quattro: Brightness down precise.
-- o.bind("ALT + XF86MonBrightnessDown", "Brightness down precise", "~/.local/bin/omarchy-brightness-display 1%-", { locked = true, repeating = true })
