# Obsidian Linux

<p align="center">
  <img src="branding/logos/obsidian-logo.svg" alt="Obsidian Linux logo" width="128" />
</p>

<p align="center">
  A Debian 13, Wayland-first Linux distribution project focused on a lightweight Labwc desktop, reproducible ISO builds, and a branded Calamares installer.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-0f172a?style=for-the-badge&logo=open-source-initiative&logoColor=white" alt="MIT License" />
  <img src="https://img.shields.io/badge/base-Debian%2013-A81D33?style=for-the-badge&logo=debian&logoColor=white" alt="Debian 13" />
  <img src="https://img.shields.io/badge/display-Wayland-5B6CFF?style=for-the-badge&logo=wayland&logoColor=white" alt="Wayland" />
  <img src="https://img.shields.io/badge/desktop-Labwc-111827?style=for-the-badge" alt="Labwc" />
  <img src="https://img.shields.io/badge/installer-Calamares-2563EB?style=for-the-badge" alt="Calamares" />
  <img src="https://img.shields.io/badge/build-live--build-1F2937?style=for-the-badge" alt="Live Build" />
  <img src="https://img.shields.io/badge/apps-Flatpak%20Ready-0EA5E9?style=for-the-badge&logo=flatpak&logoColor=white" alt="Flatpak Ready" />
</p>

## Overview

Obsidian Linux is being developed as a modern Debian-based operating system with a restrained visual identity, a minimal default desktop, and a reproducible build pipeline. The current repository is centered on the distribution foundation: building a bootable live ISO, packaging Obsidian-specific customizations as Debian packages, and integrating a branded Calamares installer.

This repository does not yet claim a completed operating system. It documents and packages the current buildable foundation only.

## Current Status

- Phase: `0.1 Development`
- Scope verified in-repo: live-build configuration, package sources, branding assets, installer configuration, and developer documentation
- Automated Linux CI: Ubuntu package build and validation workflow via GitHub Actions
- Scope still pending external verification: real Debian-host package builds, ISO boot verification, and live screenshot capture

## Hero Screenshot

Real screenshots are required for this project and are intentionally not replaced with mockups. The capture workflow is documented in [docs/screenshot-workflow.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/screenshot-workflow.md), and verified screenshots should be stored in [docs/images](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/images).

## Feature Highlights

- Debian 13 (Trixie) base with a reproducible `live-build` pipeline
- Wayland-first Labwc desktop with Waybar, Wofi, Foot, and Thunar
- Obsidian Center for lightweight system overview and core launch actions
- Obsidian System Tools for maintenance, diagnostics, health, and resource checks
- Obsidian Desktop Tools for screenshots, recording, clipboard, QR, and quick status
- Obsidian Developer Tools for opt-in language, container, database, and CLI setup
- Obsidian Software Store for curated APT and Flatpak installs
- Calamares installer integration with Obsidian branding
- Lightweight first-run welcome flow for initial orientation
- Customizations delivered through Debian packages rather than ad hoc image edits
- Structured build, validation, and test documentation

## Installation Overview

The current goal is to build and test the live ISO in a virtual machine before any hardware deployment.

```bash
git clone <repository>
cd obsidian-linux
sudo ./scripts/install-build-dependencies.sh
./scripts/build-packages.sh
sudo ./scripts/build-iso.sh
./scripts/test-iso.sh
```

Expected output:

```text
dist/obsidian-linux-amd64.iso
dist/obsidian-linux-amd64.iso.sha256
```

## Build Instructions

Build details are documented in:

- [docs/build-guide.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/build-guide.md)
- [docs/package-guide.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/package-guide.md)
- [docs/testing-guide.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/testing-guide.md)
- [flatpak/README.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/flatpak/README.md)

## Repository Structure

```text
.
├── assets/
├── branding/
├── build/
├── calamares/
├── dist/
├── docs/
├── live-build/
├── packages/
└── scripts/
```

## Desktop Editions

- `Obsidian Core`: current implementation target for the Labwc-based live ISO
- `Obsidian Plasma`: planned future edition, not implemented in this repository state
- `Obsidian Hypr`: planned future edition, not implemented in this repository state

## Screenshots

The repository is prepared for real screenshots only. Required capture targets and storage conventions are documented in:

- [docs/screenshot-workflow.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/screenshot-workflow.md)
- [docs/images/README.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/images/README.md)

## Architecture Diagrams

- [docs/diagrams/build-pipeline.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/diagrams/build-pipeline.md)
- [docs/diagrams/package-structure.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/diagrams/package-structure.md)
- [docs/diagrams/live-build-flow.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/diagrams/live-build-flow.md)
- [docs/diagrams/installer-flow.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/diagrams/installer-flow.md)
- [docs/diagrams/boot-sequence.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/diagrams/boot-sequence.md)
- [docs/diagrams/repository-layout.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/diagrams/repository-layout.md)

## Roadmap

- Complete Debian-host validation of package builds and ISO generation
- Capture and version real screenshots from the running live system
- Add release automation and published artifacts after the foundation is verified

## Contributing

Contribution guidance lives in [CONTRIBUTING.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/CONTRIBUTING.md). Please also read the [CODE_OF_CONDUCT.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/CODE_OF_CONDUCT.md) and [SECURITY.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/SECURITY.md).

## License

This project is licensed under the MIT License. See [LICENSE](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/LICENSE).

## Credits

- Debian, for the upstream base system and packaging ecosystem
- `live-build`, for reproducible live image composition
- Labwc, Waybar, Wofi, Foot, Thunar, and Calamares upstream projects
