# Omarchy default text sizes — agent handoff (2026-09-25)

## Status and next instruction

This is a **paused, user-testing project**. Mr. Richards wants to drive the settings for several days. The upstream PR is **open as a draft**, not ready for review. Do not mark it ready, push another revision, alter the machine, or change channel/dev-link state without his explicit request. The live machine is on stable Omarchy, not the source checkout.

- Draft PR: **https://github.com/omacom/omarchy/pull/13206** — “Unify desktop typography defaults around a 13px shell base.”
- Development checkout: `~/Work/github.com/omacom/omarchy`, branch `improve-gtk-text-size-default`, fork `origin=https://github.com/TyRichards/omarchy.git`, canonical `upstream=https://github.com/omacom/omarchy.git`. Last pushed PR head when handed off: `c46bd21a` (verify on GitHub before working). It was clean at handoff. Never use the older, unrelated `~/Work/github.com/basecamp/omarchy` clone/branch or recreate `~/dev`.
- Editable PR body draft: `~/Work/workspaces/omarchy-typography-pr/PR.md`; `gh pr edit 13206 --repo omacom/omarchy --body-file ...` after approved edits.
- User dotfiles: `~/dotfiles` (this handoff is under `~/dotfiles/handoffs/`). Follow global instructions in `~/.pi/agent/AGENTS.md` and source checkout `AGENTS.md`.

## Intent and final approved proposal

On a new install, unify **13px Omarchy Quickshell base / 9pt terminal fonts / Adwaita Sans 9pt GNOME/GTK at text scale 1.0**. The GNOME font setting and terminal font settings are in **points**, shell base in **pixels**. Mr. Richards tested 10pt GNOME and 10pt terminals, then deliberately selected **9pt for both**. Do not revert that without asking.

The Display panel keeps seven stops but changes them from installed `[9, 10, 11, 12, 14, 16, 20]` to PR `[10, 11, 12, 13, 14, 16, 18]`. `omarchy-display-text-size` uses **13px shell → GTK 1.0 → 9pt terminal** as its anchor; at other stops it rounds effective GTK points and terminal points using the existing formulas. The GNOME `font-name` remains 9pt; the slider varies `text-scaling-factor`. 10px and 11px stops may round to the same GTK/terminal size while shell text differs. Current *installed* Omarchy still uses the old slider stops and 12px/9pt math, so do **not** use its slider or `omarchy display text size 13` to establish these new baselines: the latter changes GTK scaling. The checkout was tested in isolation; Mr. Richards explicitly **declined** the official `omarchy dev link`/reboot needed to activate it live.

PR source areas: `install/user/first-run/gnome-theme.sh` sets Adwaita Sans 9; `default/themed/shell.toml.tpl` and `shell/Commons/Style.qml` set shell fallback/theme to 13; `shell/plugins/panels/monitor/Panel.qml` has seven stops; `bin/omarchy-display-text-size` anchors 13/9 and GTK fallback 9; shipped terminal configs (`config/{alacritty,foot,ghostty}`, `etc/xdg/kitty`) already had 9pt defaults upstream and therefore no longer appear in the net PR diff. `shell/Ui/OpticalGlyph.qml` fixes subpixel bar icon centering exposed by 13px; Dell XPS 13 hardware adjustment becomes 12px (one below new base); docs and tests updated.

## Current local machine — distinguish from future PR defaults

Last verified live (2026-09-25): `~/.config/omarchy/shell.toml` is a **regular file**, `[font] base-size = 13`; `gsettings get org.gnome.desktop.interface font-name` → `'Adwaita Sans 9'`; `gsettings get org.gnome.desktop.interface text-scaling-factor` → `1.0`; GTK3/GTK4 `gtk-query-settings`/`gtk4-query-settings` reported Adwaita Sans 9. Foot, Ghostty, Alacritty, and Kitty live configs resolve through directory symlinks to their `~/dotfiles/<app>/.config/<app>/` files; all four numeric fonts are **9pt**. The monitor is 2880×1920 at display scale **2** (`GDK_SCALE=2`), separate from GNOME text scaling 1.0.

The current theme’s `~/.local/state/omarchy/current/theme/shell.toml` has `base-size = 11`, but the **user override 13 should win**; an `omarchy restart shell` was done to force a fresh read after a previous stale file watcher caused slider snap-back. Do not edit the packaged `/usr/share/omarchy/` files. The old installed Display slider still has no 13 stop.

Four terminal dotfiles were deliberately kept with explicit font overrides until the PR is actually packaged. Their **padding came from the Sept 23 Dropbox `dotfiles.zip`**, and should remain untouched unless requested: Foot `pad=35x35x35x25`; Ghostty `window-padding-x=35`, `window-padding-y=35,25`; Alacritty `padding.x=35`, `padding.y=35`; Kitty `window_padding_width 35 35 25 35`. Current source archive: `~/Zammis Marketing Dropbox/Ty Richards/Backups/Ty-Framework-13-Backup-Sept23-2026/dotfiles.zip`. Previous live backups are timestamped under `~/Documents/backups/`.

The dormant GTK3/GTK4 `settings.ini` files remain **in** the dotfiles but are **not stowed**; GTK font settings in GNOME/dconf override their `gtk-font-name` anyway. `gtk/.config/gnome-interface.reference.ini` is stowed but expressly **reference-only**, now records 9pt. The optional manual `~/.local/bin/omarchy-restore-gtk-font-default` symlinks to `~/dotfiles/omarchy/.local/bin/` and restores 9pt while preserving family; it does not change scaling. `~/dotfiles/omarchy/.config/` was intentionally removed; leave the live `~/.config/omarchy/shell.toml` alone.

Brave draws much of its own toolbar/tab/menu UI; it can appear too large even with GTK 9pt. The site zoom/content size was good and should not be altered. Brave’s `--force-device-scale-factor` also affects web content and was rejected as a UI-only solution. Brave’s `~/.config/brave-flags.conf` includes `OverlayScrollbar`, not a device-scale override.

## PR screenshots and publication

- A user-annotated **Before** screenshot is included in the PR body, hosted on a separate branch in the user's fork, `typography-pr-visuals`, so no PNGs are added to upstream code diff: `https://raw.githubusercontent.com/TyRichards/omarchy/typography-pr-visuals/docs/pr-screenshots/typography-before.png`.
- Side-branch worktree: `~/Work/worktrees/github.com/omacom/omarchy/typography-pr-visuals`. The older `typography-after.png` **claims terminals are 10pt**, so Mr. Richards explicitly requested its removal from the PR body after changing the proposal to 9pt; it remains on the asset branch but must **not** be relinked as evidence. PR text says a fresh After screenshot is pending. Only add one if he supplies/approves a truthful 13px/9pt/9pt capture.
- Temporary representative bar previews of seven stops were visually inspected at nominal 1×/2×: `/tmp/omarchy-type-visual-bHizSb/montage-1x.png` and `montage-2x.png` (may disappear after reboot). These are synthetic bar/icon previews, not a dev-linked live slider test.

## Validation and known blockers

Affected focused checks passed after the last 9pt GNOME revision: `bash test/shell.d/text-size-default-test.sh` (first-run 9pt, all seven stops, shell/GTK/four terminals, reset), `kitty-config-test.sh`, `bar-icon-geometry-test.sh`, bar tests and theme staging. QML bar-icon geometry passed across all seven stops at Qt scale factors 0.5, 1 and 1.5. `bash -n` and `git diff --check` passed. The full `./test/all` is **not green on this host** due to existing local prerequisites/fixtures (`omarchy-pkgs` checkout, `omasnap`, kernel headers, VS Code generated-theme check); three intermittent QML temp cleanup races passed when rerun individually. Do not claim the full suite passed or run production migrations locally.

The PR is intentionally **draft** because Mr. Richards said he wants to test for days; it has no reviews/comments as of handoff (recheck). Prior chronology: PR initially proposed terminal10/GTK10, then terminal9/GTK10, then terminal9/GTK9. The branch was amended and force-with-lease pushed while there were no reviews/comments, with explicit user requests. If future reviews arrive, avoid rewriting history casually.

## For the new agent

First read this handoff, verify PR draft status and current live settings read-only, and acknowledge to Mr. Richards that you're ready for future instructions. Do **not** change fonts, PR status, screenshots, channels, live shell, or submit a new PR until explicitly asked. The user requested this new persistent Pi agent in a Herdr tab `Work > omarchy-text-sizes`, starting from `~/dotfiles` via `hdl pi`; the next instructions should arrive there.
