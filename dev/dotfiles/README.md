# Dotfiles (legacy in utils)

This directory is no longer the primary dotfiles source.

## Where active dotfiles live now

Use the standalone repository:

- https://github.com/Zhaoyilunnn/dotfiles

That repository is the active chezmoi source and currently manages:

- `~/.config/nvim` (exact)
- `~/.codex/skills/inspect-pac-proxy`

## Why this directory still exists

`utils/dev/dotfiles` keeps legacy configs that are still tracked in the `utils` repo
(`.vimrc`, `.aider.*`, `.bashrc.ext`, etc.).

The nvim/codex managed parts were moved out to the standalone dotfiles repo.

## Setup

```bash
chezmoi init --apply Zhaoyilunnn
```
