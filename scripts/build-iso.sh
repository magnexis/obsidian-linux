#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_LIVE_BUILD="$ROOT_DIR/live-build"
WORK_DIR="$ROOT_DIR/build/live-build"
PKG_DIR="$ROOT_DIR/build/artifacts"
DIST_DIR="$ROOT_DIR/dist"
ISO_NAME="obsidian-linux-amd64.iso"

required_packages=(
  "obsidian-branding"
  "obsidian-center"
  "obsidian-defaults"
  "obsidian-desktop"
  "obsidian-desktop-tools"
  "obsidian-developer-tools"
  "obsidian-calamares-settings"
  "obsidian-software-store"
  "obsidian-system-tools"
  "obsidian-welcome"
)

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "error: build-iso.sh must run as root" >&2
  exit 1
fi

for cmd in lb rsync sha256sum; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "error: required command '$cmd' not found" >&2
    exit 1
  }
done

mkdir -p "$DIST_DIR" "$WORK_DIR"

for pkg in "${required_packages[@]}"; do
  if ! find "$PKG_DIR" -maxdepth 1 -type f -name "${pkg}_*.deb" | grep -q .; then
    echo "error: missing built package for $pkg in $PKG_DIR" >&2
    exit 1
  fi
done

echo "==> Resetting live-build working directory"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"
rsync -a --delete "$SRC_LIVE_BUILD/" "$WORK_DIR/"
mkdir -p "$WORK_DIR/config/packages.chroot"

echo "==> Copying custom packages into live-build"
find "$PKG_DIR" -maxdepth 1 -type f -name "*.deb" -exec cp -f {} "$WORK_DIR/config/packages.chroot/" \;

echo "==> Cleaning previous live-build artifacts"
(
  cd "$WORK_DIR"
  ./auto/clean || true
)

echo "==> Configuring live-build"
(
  cd "$WORK_DIR"
  ./auto/config
)

echo "==> Building ISO"
(
  cd "$WORK_DIR"
  ./auto/build
)

built_iso="$(find "$WORK_DIR" -maxdepth 1 -type f \( -name "*.iso" -o -name "*.hybrid.iso" \) | head -n 1)"
if [[ -z "$built_iso" ]]; then
  echo "error: live-build did not produce an ISO" >&2
  exit 1
fi

cp -f "$built_iso" "$DIST_DIR/$ISO_NAME"
sha256sum "$DIST_DIR/$ISO_NAME" | tee "$DIST_DIR/$ISO_NAME.sha256" >/dev/null

echo "ISO ready:"
echo "  $DIST_DIR/$ISO_NAME"
echo "  $DIST_DIR/$ISO_NAME.sha256"
