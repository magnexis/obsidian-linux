# Live Build Flow

```mermaid
flowchart TD
  A[live-build/auto/config] --> B[package-lists]
  B --> C[hooks and includes]
  C --> D[packages.chroot]
  D --> E[lb build]
  E --> F[bootable ISO]
```
