# Obsidian Linux Flatpaks

This directory contains independently buildable Flatpak manifests for Obsidian Linux user-facing applications.

## Current scope

- `io.obsidianlinux.Welcome.yml` builds the sandboxed Welcome application.

System-management applications are intentionally not Flatpaks: package upgrades, boot repair, hardware configuration, and installer access require controlled host privileges that Flatpak intentionally does not grant.

## Build locally

```bash
flatpak-builder --user --force-clean --install-deps-from=flathub --repo=repo build-dir io.obsidianlinux.Welcome.yml
flatpak-builder --user --install --force-clean build-dir io.obsidianlinux.Welcome.yml
flatpak run io.obsidianlinux.Welcome
```

Use `flatpak-builder --repo=repo` before any Flathub submission. A Flathub manifest must also satisfy Flathub's app-specific metadata, licensing, and review requirements.
