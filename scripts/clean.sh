#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Removing generated build artifacts"
rm -rf "$ROOT_DIR/build/packages" "$ROOT_DIR/build/live-build" "$ROOT_DIR/build/iso-validation" "$ROOT_DIR/build/qemu"
rm -f "$ROOT_DIR/dist/obsidian-linux-amd64.iso" "$ROOT_DIR/dist/obsidian-linux-amd64.iso.sha256"

if [[ "${1:-}" == "--all-cache" ]]; then
  read -r -p "Delete the entire build directory cache? [y/N] " reply
  case "$reply" in
    y|Y) rm -rf "$ROOT_DIR/build" ;;
    *) echo "Skipped full build cache deletion." ;;
  esac
fi

echo "Cleanup complete."
