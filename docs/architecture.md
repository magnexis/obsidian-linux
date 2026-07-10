# Architecture

## Overview

Obsidian Linux Phase 2 is intentionally narrow. The goal is a reproducible Debian Live Build pipeline that produces a bootable amd64 ISO with:

- Debian 13 (Trixie) as the base
- A Labwc Wayland live session
- Obsidian custom packages for branding and defaults
- Calamares available in the live environment
- QEMU-based verification workflow

## Debian Base

The distribution foundation stays close to Debian:

- Official Debian repositories remain the primary package source
- `live-build` composes the live filesystem and bootable ISO
- Customizations are layered on top through Debian packages instead of ad hoc file copying

This keeps the image maintainable and reduces divergence from Debian.

## Live Build Role

`live-build/` defines the ISO composition process:

- `auto/config` sets the Trixie amd64 live-build profile
- `config/package-lists/` separates package concerns by role
- `config/packages.chroot/` receives locally built Obsidian `.deb` files
- `config/hooks/` performs reproducible, image-scoped adjustments
- `config/includes.*` injects small static files needed at build time

The build script copies this tree into a working directory under `build/` so source configuration stays clean.

## Custom Package Role

All Obsidian-specific behavior is delivered through four Debian packages:

- `obsidian-branding`
- `obsidian-center`
- `obsidian-defaults`
- `obsidian-desktop`
- `obsidian-desktop-tools`
- `obsidian-developer-tools`
- `obsidian-calamares-settings`
- `obsidian-software-store`
- `obsidian-system-tools`
- `obsidian-welcome`

This keeps distribution identity, session behavior, control-center behavior, software-store behavior, installer customization, and first-run guidance versioned and independently buildable with standard Debian tooling.

## Calamares Role

Calamares is part of the live environment and acts as the installer surface. The project keeps a source-of-truth copy of its configuration in `calamares/` and a Debian package that installs the active files into the target filesystem.

For this phase, the Calamares configuration is conservative:

- standard locale, keyboard, timezone, users, partition, and bootloader modules
- branded welcome and slideshow assets
- no custom Calamares module development

## Labwc Session Architecture

The default live desktop is intentionally simple:

- `labwc` compositor and session
- `waybar` panel
- `wofi` launcher
- `foot` terminal
- `thunar` file manager
- `mako` notifications
- `nm-applet` tray integration under Xwayland
- `swaylock`, `grim`, and `slurp` for lock and screenshot actions

`obsidian-desktop` installs shared system-wide configuration under `/etc/xdg` and provides a session launcher script.

`obsidian-welcome` provides a lightweight first-run experience that appears once per user session profile and points new users toward the installer, terminal, file manager, and local documentation.

`obsidian-center` provides a lightweight control surface for system summary, network state, audio-service checks, and common launch actions without introducing a heavyweight settings framework during the current repository phase.

`obsidian-software-store` provides a curated application catalog with conservative APT and Flatpak install flows suited to the current lightweight distribution phase.

`obsidian-system-tools` provides a narrow maintenance interface for updates, cleanup, hardware and driver information, kernel inspection, and snapshot capability detection.

`obsidian-desktop-tools` provides user-facing capture, recording, clipboard, QR-code, and quick-status actions designed for the Labwc session.

`obsidian-developer-tools` keeps development environments optional by exposing explicit installation flows rather than adding every toolchain to the base image.

## Build Artifact Flow

1. `install-build-dependencies.sh` installs host tools.
2. `build-packages.sh` builds the Obsidian Debian packages into `build/artifacts/`.
3. `build-iso.sh` stages those packages into `live-build/config/packages.chroot/`.
4. `live-build` produces a hybrid ISO from a clean working directory.
5. The final image is copied to `dist/obsidian-linux-amd64.iso`.
6. `validate-iso.sh` inspects the ISO structure and live filesystem.
7. `test-iso.sh` launches the ISO in QEMU for manual verification.
