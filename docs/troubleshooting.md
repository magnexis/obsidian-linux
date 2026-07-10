# Troubleshooting

## Missing Live Build Dependencies

Run:

```bash
sudo ./scripts/install-build-dependencies.sh
```

If `lb` is still missing, confirm that `live-build` installed successfully and that the host is Debian-based.

## Package Build Failure

- Run `./scripts/validate-packages.sh` to surface metadata issues.
- Check the package currently being built in `build-packages.sh` output.
- Confirm `debhelper`, `dpkg-dev`, and `devscripts` are installed.

## Calamares Missing in the Live System

- Confirm `installer.list.chroot` includes `calamares`.
- Confirm `obsidian-calamares-settings` built and was copied into `live-build/config/packages.chroot/`.
- Re-run `./scripts/validate-iso.sh`.

## ISO Not Booting

- Rebuild with `sudo ./scripts/build-iso.sh`.
- Confirm the ISO exists at `dist/obsidian-linux-amd64.iso`.
- Check that boot files are present with `./scripts/validate-iso.sh`.

## UEFI Failure

- Launch with `./scripts/test-iso.sh --uefi`.
- Confirm `ovmf` is installed on the host.
- If no OVMF firmware path is found, use BIOS mode and document the missing firmware.

## QEMU Permission Problems

- Ensure `qemu-system-x86_64` and `qemu-img` are installed.
- Confirm the user can access `/dev/kvm`, or rerun without hardware acceleration.

## Missing Firmware

- Confirm `firmware.list.chroot` contains the needed Debian firmware packages.
- Document any added third-party source before use. None are configured in this phase by default.

## SquashFS Errors

- Confirm `squashfs-tools` is installed on the host.
- Rebuild from a clean state with `./scripts/clean.sh`.
- Re-run `./scripts/validate-iso.sh` to verify the live filesystem is readable.
