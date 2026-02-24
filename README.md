# cmdtools

[![CI](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml/badge.svg)](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml)

CLI tools installer for macOS and Linux.

## Tools

| Tool | Description |
|---|---|
| `git` | Version control |
| `ghq` | Repository manager |
| `fzf` | Fuzzy finder |
| `zoxide` | Smart `cd` |
| `ripgrep` | Fast grep |
| `fd` | Fast find |
| `eza` | Modern `ls` |
| `bat` | Modern `cat` |
| `delta` | Git diff viewer |
| `difi` | Git diff reviewer |
| `sheldon` | zsh plugin manager |
| `mise` | Runtime version manager |
| `neovim` | Text editor |

## Installation

```bash
git clone https://github.com/tafuru/cmdtools.git
cd cmdtools
bash install.sh
```

On macOS, packages are installed via Homebrew. On Linux, apt handles packages available in the standard repositories; the rest are installed from official release binaries to `~/.local/bin`.

## Design Principles

- Installs tools only — configuration lives in [dotfiles](https://github.com/tafuru/dotfiles)
- Linux uses apt for standard packages; extras are fetched from official GitHub Releases (no Linuxbrew)
- `mise` is configured per-project via `mise.toml`, not globally

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.
