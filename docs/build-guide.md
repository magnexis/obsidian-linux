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
build/artifacts/
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

## Full Phase 2 Workflow

```bash
git clone <repository>
cd obsidian-linux
sudo ./scripts/install-build-dependencies.sh
./scripts/build-packages.sh
sudo ./scripts/build-iso.sh
./scripts/test-iso.sh
```
