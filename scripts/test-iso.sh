#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ISO_PATH="$ROOT_DIR/dist/obsidian-linux-amd64.iso"
DISK_PATH="$ROOT_DIR/build/qemu/obsidian-test.qcow2"
MEMORY=3072
CPUS=2
USE_UEFI=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --uefi)
      USE_UEFI=1
      shift
      ;;
    --memory)
      MEMORY="$2"
      shift 2
      ;;
    --cpus)
      CPUS="$2"
      shift 2
      ;;
    *)
      echo "error: unknown argument '$1'" >&2
      exit 1
      ;;
  esac
done

command -v qemu-system-x86_64 >/dev/null 2>&1 || {
  echo "error: qemu-system-x86_64 not found" >&2
  exit 1
}
command -v qemu-img >/dev/null 2>&1 || {
  echo "error: qemu-img not found" >&2
  exit 1
}

if [[ ! -f "$ISO_PATH" ]]; then
  echo "error: ISO not found at $ISO_PATH" >&2
  exit 1
fi

mkdir -p "$(dirname "$DISK_PATH")"
if [[ ! -f "$DISK_PATH" ]]; then
  qemu-img create -f qcow2 "$DISK_PATH" 24G >/dev/null
fi

qemu_args=(
  -m "$MEMORY"
  -smp "$CPUS"
  -drive "file=$DISK_PATH,format=qcow2"
  -cdrom "$ISO_PATH"
  -boot d
)

if [[ -e /dev/kvm ]]; then
  qemu_args+=(-enable-kvm)
fi

if [[ "$USE_UEFI" -eq 1 ]]; then
  for firmware in /usr/share/OVMF/OVMF_CODE.fd /usr/share/ovmf/OVMF.fd; do
    if [[ -f "$firmware" ]]; then
      qemu_args+=(-bios "$firmware")
      break
    fi
  done
fi

exec qemu-system-x86_64 "${qemu_args[@]}"
