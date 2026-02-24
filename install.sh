#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

info()    { echo "[cmdtools] $*"; }
success() { echo "[cmdtools] ✓ $*"; }
warn()    { echo "[cmdtools] ! $*" >&2; }
fatal()   { echo "[cmdtools] ✗ $*" >&2; exit 1; }

case "$OS" in
  Darwin)
    info "Detected macOS — installing packages via Homebrew"
    if ! command -v brew &>/dev/null; then
      info "Homebrew not found — installing"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew bundle --file "$SCRIPT_DIR/platform/macos/Brewfile"
    success "All packages installed"
    ;;
  Linux)
    info "Detected Linux — installing packages via apt"
    sudo apt-get update -q
    while IFS= read -r pkg; do
      [[ -z "$pkg" || "$pkg" == \#* ]] && continue
      if sudo apt-get install -y "$pkg" &>/dev/null; then
        success "Installed $pkg"
      else
        warn "Failed to install $pkg — skipping"
      fi
    done < "$SCRIPT_DIR/platform/linux/packages.txt"
    success "All apt packages processed"
    bash "$SCRIPT_DIR/platform/linux/extras.sh"
    ;;
  *)
    fatal "Unsupported OS: $OS"
    ;;
esac
