# cmdtools

[![CI](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml/badge.svg)](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml)

CLI tools installer for macOS and Ubuntu/Debian. Sets up a zsh environment with modern command-line tools.

## Tools

| Tool | Description |
|---|---|
| [`chezmoi`](https://chezmoi.io) | Manages dotfiles across machines using templates and a source-of-truth repository |
| [`git`](https://git-scm.com) | Distributed version control for tracking changes and collaborating on code |
| [`gh`](https://cli.github.com) | GitHub CLI for managing issues, pull requests, and workflows from the terminal |
| [`copilot`](https://github.com/github/copilot-cli) | AI-powered pair programmer that brings Copilot assistance to the command line |
| [`ghq`](https://github.com/x-motemen/ghq) | Repository manager that clones and organizes repos under a consistent directory structure |
| [`specify`](https://github.github.com/spec-kit/) | Spec-driven development tool for structuring and implementing features from specifications |
| [`fzf`](https://github.com/junegunn/fzf) | General-purpose fuzzy finder for interactive filtering of any command output or list |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` that learns your most-visited directories and jumps to them instantly |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) | Blazing-fast recursive search that respects `.gitignore` and supports regex |
| [`fd`](https://github.com/sharkdp/fd) | Fast and intuitive alternative to `find` with colorized output and smart defaults |
| [`eza`](https://github.com/eza-community/eza) | Modern `ls` replacement with color, icons, and built-in Git status support |
| [`bat`](https://github.com/sharkdp/bat) | `cat` clone with syntax highlighting, line numbers, and Git change markers |
| [`delta`](https://github.com/dandavison/delta) | Syntax-highlighting pager for `git diff` and `git show` output |
| [`difi`](https://github.com/oug-t/difi) | Interactive git diff reviewer that walks through hunks one at a time |
| [`starship`](https://starship.rs) | Minimal, fast, and customizable shell prompt that works with any shell |
| [`sheldon`](https://github.com/rossmacarthur/sheldon) | Fast zsh plugin manager with TOML-based configuration |
| [`mise`](https://mise.jdx.dev) | Polyglot runtime version manager replacing nvm, rbenv, and pyenv with per-project `.mise.toml` |
| [`neovim`](https://neovim.io) | Hyperextensible Vim-based text editor with built-in LSP and Lua configuration |
| [`zellij`](https://zellij.dev) | Terminal workspace and multiplexer with a built-in plugin system and floating panes |

## Installation

Without cloning (recommended):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tafuru/cmdtools/main/install.sh)"
```

Or clone and run:

```bash
git clone https://github.com/tafuru/cmdtools.git
cd cmdtools
bash install.sh
```

On macOS, packages are installed via Homebrew. On Ubuntu/Debian, apt handles packages available in the standard repositories; the rest are installed via Homebrew (Linuxbrew).

## Design Principles

- Installs tools only — configuration lives in [dotfiles](https://github.com/tafuru/dotfiles)
- Ubuntu/Debian uses apt for standard packages; the rest are installed via Homebrew (Linuxbrew)
- Package manifests are the source of truth: Homebrew packages live in `platform/common/Brewfile` and `platform/macos/Brewfile`, and Linux apt packages live in `platform/linux/packages.txt`
- Use mise (not Homebrew) for runtimes such as Rust, Node.js, Python — mise supports per-project version management via `.mise.toml`
- mise itself is installed by cmdtools, but runtimes are not — define them in `~/.config/mise/config.toml`; [dev-setup](https://github.com/tafuru/dev-setup) runs `mise install` automatically as the final step, or run it manually if setting up without dev-setup

## Related

- [dev-setup](https://github.com/tafuru/dev-setup) — Full machine setup (entry point)
- [devtools](https://github.com/tafuru/devtools) — GUI apps and fonts

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.
