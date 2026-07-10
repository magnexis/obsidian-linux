#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ISO_PATH="$ROOT_DIR/dist/obsidian-linux-amd64.iso"
SHA_PATH="$ISO_PATH.sha256"
WORK_DIR="$ROOT_DIR/build/iso-validation"
SQUASHFS_PATH="$WORK_DIR/filesystem.squashfs"

for cmd in xorriso unsquashfs sha256sum; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "error: required command '$cmd' not found" >&2
    exit 1
  }
done

[[ -f "$ISO_PATH" ]] || {
  echo "error: ISO not found at $ISO_PATH" >&2
  exit 1
}
[[ -f "$SHA_PATH" ]] || {
  echo "error: checksum not found at $SHA_PATH" >&2
  exit 1
}

sha256sum -c "$SHA_PATH"

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

xorriso -osirrox on -indev "$ISO_PATH" -extract /live/filesystem.squashfs "$SQUASHFS_PATH" >/dev/null 2>&1
[[ -f "$SQUASHFS_PATH" ]] || {
  echo "error: live filesystem.squashfs not found in ISO" >&2
  exit 1
}

xorriso -indev "$ISO_PATH" -find /EFI -type d >/dev/null 2>&1 || {
  echo "error: expected EFI boot files were not found" >&2
  exit 1
}
xorriso -indev "$ISO_PATH" -find /boot -type d >/dev/null 2>&1 || {
  echo "error: expected boot directory was not found" >&2
  exit 1
}

unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/share/backgrounds/obsidian/default.svg' || {
  echo "error: default wallpaper missing from live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/share/wayland-sessions/obsidian.desktop' || {
  echo "error: Labwc session files missing from live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/share/applications/install-obsidian-linux.desktop' || {
  echo "error: Calamares desktop launcher missing from live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/sbin/NetworkManager' || {
  echo "error: NetworkManager missing from live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/bin/pipewire' || {
  echo "error: PipeWire missing from live filesystem" >&2
  exit 1
}
unsquashfs -cat "$SQUASHFS_PATH" etc/os-release | grep -q 'NAME="Obsidian Linux"' || {
  echo "error: /etc/os-release does not identify Obsidian Linux" >&2
  exit 1
}
for pkg in obsidian-branding obsidian-center obsidian-defaults obsidian-desktop obsidian-desktop-tools obsidian-developer-tools obsidian-calamares-settings obsidian-software-store obsidian-system-tools obsidian-welcome; do
  unsquashfs -cat "$SQUASHFS_PATH" var/lib/dpkg/status | grep -q "^Package: $pkg$" || {
    echo "error: $pkg is not installed in the live filesystem" >&2
    exit 1
  }
done
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/bin/obsidian-center' || {
  echo "error: Obsidian Center is missing from the live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/bin/obsidian-software-store' || {
  echo "error: Obsidian Software Store is missing from the live filesystem" >&2
  exit 1
}

unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/bin/obsidian-system-tools' || {
  echo "error: Obsidian System Tools is missing from the live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/bin/obsidian-desktop-tools' || {
  echo "error: Obsidian Desktop Tools is missing from the live filesystem" >&2
  exit 1
}
unsquashfs -ll "$SQUASHFS_PATH" | grep -q 'usr/bin/obsidian-developer-tools' || {
  echo "error: Obsidian Developer Tools is missing from the live filesystem" >&2
  exit 1
}
unsquashfs -cat "$SQUASHFS_PATH" var/lib/dpkg/status | grep -q '^Package: calamares$' || {
  echo "error: calamares is not installed in the live filesystem" >&2
  exit 1
}

echo "ISO validation completed successfully."
