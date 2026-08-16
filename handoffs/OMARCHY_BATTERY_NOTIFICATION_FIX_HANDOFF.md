# Omarchy repeated low-battery notification fix — handoff

## Status

Work was intentionally paused on 2026-08-16 at Ty's request. No upstream commit was created, no branch was pushed, and no pull request was opened.

The temporary user-owned replacement remains enabled:

```text
~/.config/omarchy/plugins/trr.battery/
```

`~/.config/omarchy/shell.json` enables `trr.battery` and disables the native `omarchy.battery` service.

## Reported behavior

On a Framework Laptop 13 at 10% and below, Omarchy repeatedly displayed and stacked the critical notification:

```text
Time to recharge!
Battery is down to N%
```

Observed notifications arrived at irregular short intervals, sometimes around 10–30 seconds apart. The notification history confirmed repeated alerts at both 10% and 9% during one continuous discharge.

## Root cause

The native battery model computes its latch like this:

```js
var low = isDischarging(...) && level <= threshold
notifiedLowBattery: low
```

UPower can briefly report an unknown/non-discharging state or a temporarily missing display device while the machine remains on battery below the threshold. That transient makes `low` false and clears `notifiedLowBattery`. When UPower reports `Discharging` again, Omarchy treats it as a new low-battery event and sends another warning.

The warning should only re-arm after a real recovery:

- AC power is connected, or
- battery percentage rises above the warning threshold.

It should not re-arm because of a transient UPower device/state update.

## Temporary local replacement

The active clone uses the native `Service.qml` with a corrected `BatteryModel.js`.

Relevant logic:

```js
function shouldWarnLowBattery(device, onBattery, dischargingState, threshold, alreadyNotified) {
  var level = batteryPercentage(device)
  // UPower can briefly report an unknown state or missing display device while
  // still on battery. Only a real recovery should re-arm the warning.
  var recovered = !onBattery || (level >= 0 && level > threshold)
  var low = level >= 0 && isDischarging(device, onBattery, dischargingState) && level <= threshold
  var notifiedLowBattery = recovered ? false : alreadyNotified || low

  return {
    level: level,
    notify: low && !alreadyNotified,
    notifiedLowBattery: notifiedLowBattery
  }
}
```

Local validation:

- Plugin manifest validation passed.
- `qmllint` passed without errors.
- The exact model-based fix was tested live at 6–8% while discharging.
- Notification count did not increase over additional polling cycles.

## Proposed upstream change

Base future work on current `upstream/quattro` and modify only:

```text
shell/plugins/services/battery/BatteryModel.js
test/shell.d/battery-test.sh
```

Add model tests proving that an existing low-battery latch:

1. survives a transient non-discharging device state;
2. survives a temporarily missing display device while still on battery;
3. clears after battery percentage rises above the threshold;
4. clears after AC power is connected.

Suggested branch name:

```text
fix-low-battery-notification-latch
```

Suggested commit title:

```text
Keep low battery warning latched through UPower transitions
```

## Tests already run

Focused test passed:

```bash
bash test/shell.d/battery-test.sh
```

All added battery assertions passed.

`./test/shell` and `./test/all` were also run. They reached the battery tests successfully, but the full suite reported four failures outside the battery area:

```text
test/shell.d/bar-icon-geometry-test.sh
test/shell.d/config-test.sh
test/shell.d/snapper-test.sh
test/shell.d/unowned-system-paths-test.sh
```

The packaging-related failures explicitly reported a missing `omarchy-pkgs` checkout. Reassess the other two against a clean development environment before opening a PR.

## Upstream workflow for later

```bash
mkdir -p ~/Projects
git clone git@github.com:TyRichards/omarchy.git ~/Projects/omarchy
cd ~/Projects/omarchy
git remote add upstream git@github.com:basecamp/omarchy.git
git fetch upstream
git switch -c fix-low-battery-notification-latch upstream/quattro
```

Follow `AGENTS.md` and `agents/skills/shell-dev.md`, rerun focused and aggregate tests, make one atomic commit, push to the fork, and open a PR against `basecamp/omarchy:quattro`.
