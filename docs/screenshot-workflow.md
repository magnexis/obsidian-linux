# Screenshot Workflow

## Policy

Every screenshot in this repository must come from a real running Obsidian Linux build. Do not use AI-generated artwork, composited mockups, or placeholder images.

## Capture Resolution

Recommended resolution: `1920x1080`

## Expected Files

Store captures in [docs/images](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/images) using these names when available:

- `hero.png`
- `desktop.png`
- `launcher.png`
- `terminal.png`
- `file-manager.png`
- `installer.png`
- `settings.png`
- `about.png`
- `boot-splash.png`
- `grub-menu.png`
- `login-screen.png`
- `notification.png`
- `partition-page.png`
- `install-progress.png`
- `installed-desktop.png`
- `system-information.png`

## Repeatable Workflow

1. Build the ISO with `sudo ./scripts/build-iso.sh`.
2. Launch QEMU with `./scripts/test-iso.sh --memory 4096`.
3. Boot into the live desktop.
4. Capture screenshots inside the guest using the current desktop tools or externally from the VM display. Record the ISO checksum and capture date with the build notes.
5. Move the final verified images into `docs/images/`.
6. Run `./scripts/prepare-screenshots.sh` to verify naming and directory structure.

## Quality Standard

- Use the default wallpaper.
- Avoid debug overlays.
- Hide personal data.
- Keep window spacing and scale consistent.
- Replace outdated screenshots when the UI changes significantly.
- Do not add a screenshot when ISO boot or visual verification has not completed successfully.
