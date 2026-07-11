#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="io.github.magnexis.obsidian-linux.yml"
SOURCE_DIR="$ROOT_DIR/flatpak"

command -v flatpak >/dev/null 2>&1 || {
  echo "error: flatpak is not installed" >&2
  exit 1
}

STAGE_DIR="$(mktemp -d /var/tmp/obsidian-flatpak.XXXXXX)"
trap 'rm -rf "$STAGE_DIR"' EXIT

cp -a "$SOURCE_DIR/." "$STAGE_DIR/"
flatpak run --filesystem="$STAGE_DIR" --cwd="$STAGE_DIR" --command=flathub-build org.flatpak.Builder --install --disable-rofiles-fuse "$STAGE_DIR/$MANIFEST"
