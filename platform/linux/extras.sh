#!/usr/bin/env bash
# Install tools not available in apt.
# Binaries are placed in ~/.local/bin.
set -euo pipefail

BIN_DIR="${HOME}/.local/bin"
mkdir -p "$BIN_DIR"

info()    { echo "[cmdtools] $*"; }
success() { echo "[cmdtools] ✓ $*"; }
skip()    { echo "[cmdtools] - $* already installed — skipping"; }
warn()    { echo "[cmdtools] ! $*" >&2; }

# Architecture detection
case "$(uname -m)" in
  x86_64)  ARCH=x86_64 ;;
  aarch64) ARCH=aarch64 ;;
  *)       warn "Unsupported architecture: $(uname -m) — falling back to x86_64"; ARCH=x86_64 ;;
esac

# Fetch the latest release tag from GitHub (returns e.g. "v1.2.3")
gh_latest() {
  curl -sSfL "https://api.github.com/repos/$1/releases/latest" \
    | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"\(.*\)".*/\1/'
}

# chezmoi — https://chezmoi.io
install_chezmoi() {
  command -v chezmoi &>/dev/null && { skip chezmoi; return; }
  info "Installing chezmoi"
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
  success "chezmoi installed"
}

# zoxide — https://github.com/ajeetdsouza/zoxide
install_zoxide() {
  command -v zoxide &>/dev/null && { skip zoxide; return; }
  info "Installing zoxide"
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  success "zoxide installed"
}

# sheldon — https://github.com/rossmacarthur/sheldon
install_sheldon() {
  command -v sheldon &>/dev/null && { skip sheldon; return; }
  info "Installing sheldon"
  local tag; tag=$(gh_latest rossmacarthur/sheldon)
  local ver="${tag#v}"
  curl -sSfL "https://github.com/rossmacarthur/sheldon/releases/download/${tag}/sheldon-${ver}-${ARCH}-unknown-linux-musl.tar.gz" \
    | tar -xz -C "$BIN_DIR" sheldon
  success "sheldon installed"
}

# eza — https://github.com/eza-community/eza
install_eza() {
  command -v eza &>/dev/null && { skip eza; return; }
  info "Installing eza"
  local tag; tag=$(gh_latest eza-community/eza)
  local eza_triple; case "$ARCH" in
    aarch64) eza_triple="aarch64-unknown-linux-gnu" ;;
    *)       eza_triple="x86_64-unknown-linux-musl" ;;
  esac
  curl -sSfL "https://github.com/eza-community/eza/releases/download/${tag}/eza_${eza_triple}.tar.gz" \
    | tar -xz -C "$BIN_DIR" ./eza
  success "eza installed"
}

# mise — https://mise.jdx.dev
install_mise() {
  command -v mise &>/dev/null && { skip mise; return; }
  info "Installing mise"
  curl -sSfL https://mise.run | sh
  success "mise installed"
}

# delta — https://github.com/dandavison/delta
install_delta() {
  command -v delta &>/dev/null && { skip delta; return; }
  info "Installing delta"
  local tag; tag=$(gh_latest dandavison/delta)
  local ver="${tag#v}"
  local triple; case "$ARCH" in
    aarch64) triple="aarch64-unknown-linux-gnu" ;;
    *)       triple="x86_64-unknown-linux-musl" ;;
  esac
  curl -sSfL "https://github.com/dandavison/delta/releases/download/${tag}/delta-${ver}-${triple}.tar.gz" \
    | tar -xz --strip-components=1 -C "$BIN_DIR" "delta-${ver}-${triple}/delta"
  success "delta installed"
}

# difi — https://github.com/oug-t/difi
install_difi() {
  command -v difi &>/dev/null && { skip difi; return; }
  info "Installing difi"
  local tag; tag=$(gh_latest oug-t/difi)
  local ver="${tag#v}"
  local difi_arch; case "$ARCH" in aarch64) difi_arch=arm64 ;; *) difi_arch=x86_64 ;; esac
  curl -sSfL "https://github.com/oug-t/difi/releases/download/${tag}/difi_Linux_${difi_arch}.tar.gz" \
    | tar -xz -C "$BIN_DIR" difi
  success "difi installed"
}

# ghq — https://github.com/x-motemen/ghq
install_ghq() {
  command -v ghq &>/dev/null && { skip ghq; return; }
  info "Installing ghq"
  local tag; tag=$(gh_latest x-motemen/ghq)
  local tmp; tmp=$(mktemp -d)
  local ghq_arch; case "$ARCH" in aarch64) ghq_arch=arm64 ;; *) ghq_arch=amd64 ;; esac
  curl -sSfL "https://github.com/x-motemen/ghq/releases/download/${tag}/ghq_linux_${ghq_arch}.zip" \
    -o "$tmp/ghq.zip"
  unzip -q "$tmp/ghq.zip" -d "$tmp"
  cp "$tmp/ghq_linux_${ghq_arch}/ghq" "$BIN_DIR/ghq"
  rm -rf "$tmp"
  success "ghq installed"
}

# zellij — https://github.com/zellij-org/zellij
install_zellij() {
  command -v zellij &>/dev/null && { skip zellij; return; }
  info "Installing zellij"
  local tag; tag=$(gh_latest zellij-org/zellij)
  local ver="${tag#v}"
  curl -sSfL "https://github.com/zellij-org/zellij/releases/download/${tag}/zellij-${ARCH}-unknown-linux-musl.tar.gz" \
    | tar -xz -C "$BIN_DIR" zellij
  success "zellij installed"
}

# starship — https://github.com/starship/starship
install_starship() {
  command -v starship &>/dev/null && { skip starship; return; }
  info "Installing starship"
  curl -sSfL https://starship.rs/install.sh | sh -s -- --bin-dir "$BIN_DIR" --yes
  success "starship installed"
}

install_chezmoi
install_zoxide
install_sheldon
install_eza
install_mise
install_delta
install_difi
install_ghq
install_zellij
install_starship

success "All extras installed to $BIN_DIR"
