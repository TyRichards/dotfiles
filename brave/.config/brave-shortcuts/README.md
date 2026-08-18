# Brave shortcuts

Brave stores both extension commands and browser accelerators inside its
frequently rewritten profile `Preferences` file. Do not symlink that file.

This stow package keeps only the desired shortcuts in `config.json` and installs
`brave-shortcuts`, which safely patches those entries while preserving the rest
of the browser profile.

```bash
stow brave
brave-shortcuts          # check current values
brave-shortcuts --apply  # apply after fully closing Brave
```

The apply command creates `Preferences.brave-shortcuts.bak` before writing.
