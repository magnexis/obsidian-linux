#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_DIR="$ROOT_DIR/build/packages"
expected=(
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

[[ -d "$PKG_DIR" ]] || {
  echo "error: package directory not found: $PKG_DIR" >&2
  exit 1
}

for pkg in "${expected[@]}"; do
  deb="$(find "$PKG_DIR" -maxdepth 1 -type f -name "${pkg}_*.deb" | head -n 1)"
  [[ -n "$deb" ]] || {
    echo "error: missing package artifact for $pkg" >&2
    exit 1
  }

  echo "==> Inspecting $deb"
  dpkg-deb -I "$deb" >/dev/null

  package_name="$(dpkg-deb -f "$deb" Package)"
  package_version="$(dpkg-deb -f "$deb" Version)"
  [[ "$package_name" == "$pkg" ]] || {
    echo "error: unexpected package name '$package_name' in $deb" >&2
    exit 1
  }
  [[ -n "$package_version" ]] || {
    echo "error: missing version in $deb" >&2
    exit 1
  }

  if command -v lintian >/dev/null 2>&1; then
    lintian "$deb"
  else
    echo "error: lintian not installed; cannot skip validation" >&2
    exit 1
  fi
done

echo "Package validation completed successfully."
