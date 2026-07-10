# Build Environment

## Intended Host

- Debian 13 or another Debian-based amd64 host
- `sudo` access
- `live-build`, `dpkg-buildpackage`, and QEMU tooling installed through the project scripts

## Why Linux Is Required for Verification

The build and screenshot workflows rely on Debian packaging and virtual machine tooling that are meant to run on a Linux host. This repository can be edited elsewhere, but authoritative verification should happen on a supported build host.
