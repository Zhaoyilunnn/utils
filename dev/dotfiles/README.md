# Dotfiles (managed by chezmoi)

This directory is the `chezmoi` source for this machine.

## Why chezmoi

`chezmoi` makes dotfiles reproducible across devices:

- track desired state in Git
- preview changes before apply
- selectively manage files/directories
- support exact directories when needed

## Current managed scope

- `~/.config/nvim` (managed as `exact`)
- `~/.codex/skills/inspect-pac-proxy` (non-exact)
- `~/bootstrap.sh`

Notes:

- `exact` means extra files in target directory can be removed.
- non-exact means only declared files are synced; unrelated extra files are usually kept.

## Daily commands

```bash
# confirm source
chezmoi source-path

# check what is managed
chezmoi managed

# check drift
chezmoi status
chezmoi diff

# apply desired state
chezmoi apply
```

## Bootstrap on a new machine

```bash
git clone https://github.com/Zhaoyilunnn/utils.git ~/utils
~/utils/dev/dotfiles/bootstrap.sh
```

`bootstrap.sh` runs:

```bash
chezmoi init --source <this-directory>
chezmoi apply
```

## Add new managed targets

```bash
# preview
chezmoi add -n -v ~/.somefile

# manage
chezmoi add ~/.somefile
```

For a directory that must be fully controlled:

```bash
chezmoi add --exact ~/.some-directory
```

To stop managing a target:

```bash
chezmoi forget --force ~/.somefile
```
