# Build Guide

## Host Requirements

- Debian 13 or newer Debian-based host, or recent Ubuntu LTS
- amd64 architecture
- `sudo` access
- Enough free disk space for package builds and live-build working files

## Install Dependencies

```bash
sudo ./scripts/install-build-dependencies.sh
```

## Build Custom Debian Packages

```bash
./scripts/build-packages.sh
```

Expected output directory:

```text
build/packages/
```

## Build the ISO

```bash
sudo ./scripts/build-iso.sh
```

Expected output files:

```text
dist/obsidian-linux-amd64.iso
dist/obsidian-linux-amd64.iso.sha256
```

## Validate the Outputs

```bash
./scripts/validate-packages.sh
./scripts/validate-iso.sh
```

## Launch in QEMU

```bash
./scripts/test-iso.sh
./scripts/test-iso.sh --uefi
./scripts/test-iso.sh --memory 4096
```

## Build the Welcome Flatpak

The initial sandboxed app is `io.obsidianlinux.Welcome`. Install Flatpak tooling and add Flathub first:

```bash
sudo apt install flatpak flatpak-builder
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

Build and install it with:

```bash
cd flatpak
flatpak-builder --user --force-clean --install-deps-from=flathub --repo=repo build-dir io.obsidianlinux.Welcome.yml
flatpak-builder --user --install --force-clean build-dir io.obsidianlinux.Welcome.yml
flatpak run io.obsidianlinux.Welcome
```

When building from WSL, stage the `flatpak/` directory inside the Linux filesystem (for example, under `~/`) first. `flatpak-builder` uses FUSE overlays that cannot run from a Windows-mounted path such as `/mnt/c`.

## Full Phase 2 Workflow

```bash
git clone <repository>
cd obsidian-linux
sudo ./scripts/install-build-dependencies.sh
./scripts/build-packages.sh
sudo ./scripts/build-iso.sh
./scripts/test-iso.sh
```
