# couplet-physical-ai/homebrew-tap

Homebrew casks for couplet-physical-ai apps.

```sh
brew tap couplet-physical-ai/tap
brew trust couplet-physical-ai/tap   # Homebrew 7+: allow casks from this non-official tap
brew install --cask switchyard
```

| Cask | App |
|---|---|
| `switchyard` | [Switchyard](https://github.com/couplet-physical-ai/switchyard): a live control room for a whole CI/CD fleet (macOS, Apple Silicon) |

Upgrade with `brew upgrade --cask switchyard`; remove with `brew uninstall --cask switchyard`
(`--zap` also removes its settings).

The casks are bumped automatically by each app's release workflow (a deploy key with write
access to this repo). The apps are ad-hoc signed (no Developer ID); each cask's `postflight`
removes the download quarantine flag so macOS opens them.
