# cmdtools

[![CI](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml/badge.svg)](https://github.com/tafuru/cmdtools/actions/workflows/ci.yml)

Install CLI tools for macOS and Ubuntu/Debian. This repository provides the command-line layer for the broader setup, while shell, editor, and prompt configuration lives in [dotfiles](https://github.com/tafuru/dotfiles).

## Quick Start

Without cloning:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tafuru/cmdtools/main/install.sh)"
```

Or clone and run locally:

```bash
git clone https://github.com/tafuru/cmdtools.git
cd cmdtools
bash install.sh
```

## When to Use This Repository

- Use this repository when you want the CLI tool layer only.
- Use [dev-setup](https://github.com/tafuru/dev-setup) when you want CLI tools, dotfiles, runtimes, and optional GUI apps in one flow.
- Use [dotfiles](https://github.com/tafuru/dotfiles) alongside this repository when you want the corresponding shell and editor configuration.

## Tool Highlights

| Category | Representative tools | Purpose |
|---|---|---|
| Repository and workflow | [chezmoi](https://chezmoi.io), [git](https://git-scm.com), [gh](https://cli.github.com), [ghq](https://github.com/x-motemen/ghq), [Copilot CLI](https://github.com/github/copilot-cli), [Spec Kit](https://github.github.com/spec-kit/) | Manage repositories, workflows, and specification-driven development from the terminal |
| Navigation and search | [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide), [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd) | Jump between directories and search files or code quickly |
| Shell and prompt | [zsh](https://www.zsh.org), [sheldon](https://github.com/rossmacarthur/sheldon), [starship](https://starship.rs) | Provide the shell foundation used by the companion dotfiles |
| Editing and terminal workflow | [Neovim](https://neovim.io), [Zellij](https://zellij.dev), [bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [delta](https://github.com/dandavison/delta), [difi](https://github.com/oug-t/difi) | Support everyday editing, browsing, and review work in the terminal |
| Runtime management | [mise](https://mise.jdx.dev) | Manage project runtimes such as Node.js, Python, and Rust |

## Platform Notes

- On macOS, packages are installed through Homebrew.
- On Ubuntu/Debian, standard packages come from apt and the rest are installed through Homebrew (Linuxbrew).
- Runtime versions are not installed here; define them in `~/.config/mise/config.toml` and run `mise install`, or use [dev-setup](https://github.com/tafuru/dev-setup) to do that as part of the full setup.

## Design Principles

- Installs tools only; configuration lives in [dotfiles](https://github.com/tafuru/dotfiles).
- Uses the most practical package manager for each platform.
- Keeps the CLI layer separate from GUI apps and fonts in [devtools](https://github.com/tafuru/devtools).

## Related Repositories

| Repository | Responsibility |
|---|---|
| [dev-setup](https://github.com/tafuru/dev-setup) | Full machine setup and orchestration |
| [dotfiles](https://github.com/tafuru/dotfiles) | Shell, editor, prompt, and terminal configuration |
| [devtools](https://github.com/tafuru/devtools) | Optional GUI apps and fonts |

## Contributing

README stays focused on what this repository installs and when to use it. For manifest layout, validation commands, and CI details, see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.
