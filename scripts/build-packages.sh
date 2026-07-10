#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build/artifacts"
STAGING_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$STAGING_DIR"
}
trap cleanup EXIT

packages=(
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

if ! command -v dpkg-buildpackage >/dev/null 2>&1; then
  echo "error: dpkg-buildpackage is not installed" >&2
  exit 1
fi

mkdir -p "$BUILD_DIR"
find "$BUILD_DIR" -maxdepth 1 -type f -name "*.deb" -delete

for pkg in "${packages[@]}"; do
  source_dir="$ROOT_DIR/packages/$pkg"
  pkg_dir="$STAGING_DIR/$pkg"

  echo "==> Validating metadata for $pkg"
  test -f "$source_dir/debian/control"
  test -f "$source_dir/debian/changelog"
  test -f "$source_dir/debian/rules"
  test -f "$source_dir/debian/install"
  test -f "$source_dir/debian/source/format"
  dpkg-parsechangelog -l"$source_dir/debian/changelog" >/dev/null

  # Build from a native Linux staging directory. This prevents permission
  # metadata from Windows-mounted workspaces from turning debhelper manifests
  # such as debian/install into executable configuration files.
  rsync -a "$source_dir/" "$pkg_dir/"
  chmod a-x "$pkg_dir/debian/install"

  echo "==> Building $pkg"
  (
    cd "$pkg_dir"
    dpkg-buildpackage -us -uc -b
  )

  find "$STAGING_DIR" -maxdepth 1 -type f -name "${pkg}_*.deb" -exec cp -f {} "$BUILD_DIR/" \;
done

echo "Built packages:"
find "$BUILD_DIR" -maxdepth 1 -type f -name "*.deb" | sort
