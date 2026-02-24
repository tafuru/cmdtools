# cmdtools

[![CI](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml/badge.svg)](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml)

CLI tools installer for macOS and Linux. Sets up a zsh environment with modern command-line tools.

## Tools

| Tool | Description |
|---|---|
| [`chezmoi`](https://chezmoi.io) | Dotfiles manager |
| [`git`](https://git-scm.com) | Version control |
| [`ghq`](https://github.com/x-motemen/ghq) | Repository manager |
| [`fzf`](https://github.com/junegunn/fzf) | Fuzzy finder |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | Smart `cd` |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) | Fast grep |
| [`fd`](https://github.com/sharkdp/fd) | Fast find |
| [`eza`](https://github.com/eza-community/eza) | Modern `ls` |
| [`bat`](https://github.com/sharkdp/bat) | Modern `cat` |
| [`delta`](https://github.com/dandavison/delta) | Git diff viewer |
| [`difi`](https://github.com/oug-t/difi) | Git diff reviewer |
| [`sheldon`](https://github.com/rossmacarthur/sheldon) | zsh plugin manager |
| [`mise`](https://mise.jdx.dev) | Runtime version manager |
| [`neovim`](https://neovim.io) | Text editor |

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

On macOS, packages are installed via Homebrew. On Linux, apt handles packages available in the standard repositories; the rest are installed from official release binaries to `~/.local/bin`.

## Design Principles

- Installs tools only — configuration lives in [dotfiles](https://github.com/tafuru/dotfiles)
- Linux uses apt for standard packages; extras are fetched from official GitHub Releases (no Linuxbrew)
- Use mise (not Homebrew) for runtimes such as Bun, Rust, Node.js, Python — mise supports per-project version management via `.mise.toml`
- mise itself is installed by cmdtools, but runtimes are not — define them in `~/.config/mise/config.toml` and run `mise install` manually after setup

## Related

For a full machine setup including dotfiles, see [dev-setup](https://github.com/tafuru/dev-setup).

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.
