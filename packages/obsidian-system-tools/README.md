# obsidian-system-tools

Provides a deliberately small maintenance interface for Obsidian Linux.

Current scope:

- apply APT updates after explicit confirmation
- inspect PCI hardware, loaded drivers, storage, and kernel packages
- report snapshot-manager availability
- remove unused APT packages and clean the package cache
- inventory themes, wallpapers, fonts, and autostart entries
- report boot-repair context, resources, journal warnings, and system health
- run a lightweight memory-throughput benchmark

It does not automatically repair bootloaders, configure proprietary drivers, or replace a full graphical settings framework.
