#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "error: install-build-dependencies.sh must run as root" >&2
  exit 1
fi

if [[ ! -r /etc/os-release ]]; then
  echo "error: unable to detect host operating system" >&2
  exit 1
fi

. /etc/os-release

case "${ID:-}" in
  debian|ubuntu)
    ;;
  *)
    echo "error: unsupported host '${ID:-unknown}'. Debian or Ubuntu is required." >&2
    exit 1
    ;;
esac

packages=(
  build-essential
  debhelper
  debootstrap
  devscripts
  dpkg-dev
  fakeroot
  grub-efi-amd64-bin
  grub-pc-bin
  isolinux
  lintian
  live-build
  mtools
  ovmf
  qemu-system-x86
  qemu-utils
  rsync
  squashfs-tools
  xorriso
)

echo "==> Updating package index"
apt-get update

echo "==> Installing build dependencies"
DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}"

echo "==> Build dependencies installed successfully"
