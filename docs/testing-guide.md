# Testing Guide

## Automated Checks

Package validation:

```bash
./scripts/validate-packages.sh
```

ISO validation:

```bash
./scripts/validate-iso.sh
```

Smoke tests:

```bash
./tests/smoke/packages-smoke.sh
./tests/smoke/iso-smoke.sh
```

## QEMU Launch

```bash
./scripts/test-iso.sh
./scripts/test-iso.sh --uefi
./scripts/test-iso.sh --memory 4096
```

## Required Smoke Assertions

The automated validation path checks for:

1. ISO file generation
2. ISO checksum generation
3. Presence of the live filesystem
4. Presence of the Obsidian branding package
5. Presence of Labwc session files
6. Presence of the Calamares launcher
7. Presence of NetworkManager
8. Presence of PipeWire
9. Presence of the default wallpaper
10. Correct Obsidian identity in `/etc/os-release`

## Manual Acceptance Test

The following procedure is required for phase acceptance:

1. Build the ISO.
2. Launch it in QEMU.
3. Confirm the boot menu appears.
4. Boot into the live session.
5. Confirm the Obsidian wallpaper loads.
6. Confirm Waybar appears.
7. Open Wofi.
8. Open Foot.
9. Open Thunar.
10. Confirm networking is available.
11. Confirm audio services start.
12. Launch Calamares.
13. Install onto the temporary QEMU disk.
14. Reboot from the installed disk.
15. Confirm the installed system reaches the Labwc session.
16. Confirm the user account works.
17. Confirm the system identifies itself as Obsidian Linux.

Status: pending manual verification on a Debian or Ubuntu build host with QEMU available.
