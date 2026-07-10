# Package Guide

## Package Set

Phase 2 contains four Obsidian-owned Debian packages:

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

## Package Layout

Each package directory contains:

- `README.md`
- `debian/control`
- `debian/changelog`
- `debian/rules`
- `debian/copyright`
- `debian/install`

Most package payload files live under a local `src/` directory and are installed through `debian/install`.

## Updating a Package

1. Edit the package payload files under `src/`.
2. Update `debian/install` if file locations changed.
3. Increment the version in `debian/changelog`.
4. Rebuild with:

```bash
./scripts/build-packages.sh
```

5. Validate with:

```bash
./scripts/validate-packages.sh
```

## Creating a New Package

Follow the same minimal Debian source structure already used in `packages/`. New packages should remain narrow in scope and should not replace existing packages with broad catch-all logic.

## Packaging Rules

- Keep Obsidian files inside packages rather than injecting them directly through live-build.
- Prefer static files and simple maintainer scripts over complex post-install logic.
- Use Debian dependencies to pull runtime packages instead of duplicating package lists in unrelated places.
