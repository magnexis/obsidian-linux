# Contributing

## Scope

Contributions should stay aligned with the current repository phase. At this stage, the focus is the Obsidian Linux distribution foundation, documentation accuracy, packaging, and reproducible ISO workflows.

## Before You Start

1. Read [README.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/README.md).
2. Read [docs/architecture.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/architecture.md).
3. Check [docs/testing-guide.md](/C:/Users/matth/OneDrive/Desktop/company/obsidian-linux/docs/testing-guide.md) before changing build or installer behavior.

## Development Guidelines

- Keep changes narrow and phase-appropriate.
- Prefer official Debian packages and conservative defaults.
- Do not present unverified functionality as complete.
- Keep Obsidian-specific behavior inside Debian packages when practical.
- Update documentation when build steps or behavior change.

## Pull Requests

- Describe what changed and why.
- Include validation notes.
- Call out anything unverified.
- Attach real screenshots only when taken from the current running system.

## Commit Expectations

- Keep commits focused.
- Avoid mixing documentation-only cleanup with unrelated functional changes.
- Preserve working files unless a change is necessary and explained.
