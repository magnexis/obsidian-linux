# Obsidian Linux Flatpaks

This directory contains independently buildable Flatpak manifests for Obsidian Linux user-facing applications.

## Current scope

- `io.github.magnexis.obsidian-linux.yml` builds the sandboxed Welcome application.

System-management applications are intentionally not Flatpaks: package upgrades, boot repair, hardware configuration, and installer access require controlled host privileges that Flatpak intentionally does not grant.

## Build locally

```bash
flatpak-builder --user --force-clean --install-deps-from=flathub --repo=repo build-dir io.github.magnexis.obsidian-linux.yml
flatpak-builder --user --install --force-clean build-dir io.github.magnexis.obsidian-linux.yml
flatpak run io.github.magnexis.obsidian-linux
```

Use `flatpak-builder --repo=repo` before any Flathub submission. A Flathub manifest must also satisfy Flathub's app-specific metadata, licensing, and review requirements.
