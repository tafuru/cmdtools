#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"
TMPDIR_CLEANUP=false

info()    { echo "[cmdtools] $*"; }
success() { echo "[cmdtools] ✓ $*"; }
warn()    { echo "[cmdtools] ! $*" >&2; }
fatal()   { echo "[cmdtools] ✗ $*" >&2; exit 1; }

case "$OS" in
  Darwin) PLATFORM_FILE="$SCRIPT_DIR/platform/macos/Brewfile" ;;
  Linux)  PLATFORM_FILE="$SCRIPT_DIR/platform/linux/packages.txt" ;;
  *)      fatal "Unsupported OS: $OS" ;;
esac

# When run via curl (platform file not present), fetch from GitHub
if [ ! -f "$PLATFORM_FILE" ]; then
  info "No local repository detected — fetching platform files"
  SCRIPT_DIR=$(mktemp -d)
  BASE="https://raw.githubusercontent.com/tafuru/cmdtools/main"
  mkdir -p "$SCRIPT_DIR/platform/macos" "$SCRIPT_DIR/platform/linux"
  curl -sSfL "$BASE/platform/macos/Brewfile"         -o "$SCRIPT_DIR/platform/macos/Brewfile"
  curl -sSfL "$BASE/platform/linux/packages.txt"     -o "$SCRIPT_DIR/platform/linux/packages.txt"
  curl -sSfL "$BASE/platform/linux/extras.sh"        -o "$SCRIPT_DIR/platform/linux/extras.sh"
  TMPDIR_CLEANUP=true
fi

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

if [ "$TMPDIR_CLEANUP" = true ]; then
  rm -rf "$SCRIPT_DIR"
fi
