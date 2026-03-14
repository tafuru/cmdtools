# Contributing to cmdtools

Thanks for contributing. This document contains maintainer-facing details such as manifest layout, validation, and CI behavior.

## Development Principles

- Keep `README.md` user-facing. Manifest details and CI notes belong here.
- Install tools only; configuration belongs in [dotfiles](https://github.com/tafuru/dotfiles).
- Prefer standard package managers on each platform before introducing custom install logic.
- Keep curl mode and clone mode behavior aligned.

## Source of Truth

- `platform/common/Brewfile` defines Homebrew packages used on both macOS and Linux.
- `platform/macos/Brewfile` defines macOS-only Homebrew packages.
- `platform/linux/packages.txt` defines Linux packages installed via apt.
- `install.sh` is the entry point and also handles fetching manifest files in curl mode.

## How to Make Changes

- Prefer `platform/linux/packages.txt` for packages available in standard Ubuntu/Debian repositories.
- Use `platform/common/Brewfile` for tools that should exist on both platforms or are better provided by Homebrew.
- Use `platform/macos/Brewfile` for macOS-only packages.
- Keep naming and descriptions consistent in the README, including `Spec Kit`.
- If a tool belongs in the GUI layer instead of the CLI layer, add it to [devtools](https://github.com/tafuru/devtools) instead.

## Validation

Recommended checks before merging:

```bash
bash install.sh
```

Re-run the installer to check idempotency:

```bash
bash install.sh
```

Helpful platform-specific checks include:

```bash
brew bundle check --file platform/common/Brewfile
```

```bash
brew bundle check --file platform/macos/Brewfile
```

On Linux, verify apt-installed packages with `dpkg -s` for entries in `platform/linux/packages.txt`.

## CI Overview

CI currently validates the following:

- `shellcheck` on `install.sh`
- clone mode and curl mode on macOS and Ubuntu runners
- package presence from apt and Homebrew manifests instead of hardcoded lists
- installer idempotency in clone mode
- downstream notification to [dev-setup](https://github.com/tafuru/dev-setup) after successful pushes to `main`

## Repo-Specific Notes

- When running through `curl`, `install.sh` fetches the manifest files from GitHub based on `CMDTOOLS_BRANCH`.
- Keep the manifest files authoritative and avoid duplicating package lists in scripts or CI.
- If you add a package that affects the full setup flow, consider whether companion documentation in `dev-setup` should also be updated.
