#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$ROOT_DIR/docs/images"

required=(
  hero.png
  desktop.png
  launcher.png
  terminal.png
  file-manager.png
  installer.png
  settings.png
  about.png
)

mkdir -p "$TARGET_DIR"

echo "Checking screenshot directory: $TARGET_DIR"
for name in "${required[@]}"; do
  if [[ -f "$TARGET_DIR/$name" ]]; then
    echo "present: $name"
  else
    echo "missing: $name"
  fi
done

echo "No placeholder screenshots were generated."
