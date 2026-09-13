# neovim

The Neovim configuration is managed in a standalone chezmoi repo:
`https://github.com/Zhaoyilunnn/dotfiles`.

To apply dotfiles on a machine:

```bash
chezmoi init --apply Zhaoyilunnn
```

# Vim

The current `.vimrc` in this repository (`dev/dotfiles/.vimrc`) aims for vim>=9.0 (although it runs correctly on vim<9.0 now).

In the future, I plan to add some configurations that may only work on vim>=9.0

For example, the [`catppuccin`](https://github.com/catppuccin/nvim) plugin only supports 9.0+ with lua compilation.

My older config for vim==8.2 can be found in `tags/v0.1.0`

## Latex

- [How I'm able to take notes in mathematics lectures using LaTeX and Vim](https://castel.dev/post/lecture-notes-1/)
- [latex-snippets](https://github.com/gillescastel/latex-snippets)

## Build Vim From Source

Building vim is simple. But you need to read the instructions in its code repository.

A sample workflow is

1. Clone the repository

```bash
git clone https://github.com/vim/vim.git
cd vim
```

2. Change the [`src/Makefile`](https://github.com/vim/vim/blob/d3ff129ce8c68770c47d72ab3f30a21c19530eee/src/Makefile) configurations, just read the comments in this file. For example, if you would like to build with python3 and lua support. You can turn on corresponding options as below. Make sure to read the comments above and install required development libraries of python and lua.

```bash
# ...
CONF_OPT_PYTHON3 = --enable-python3interp
# ...
CONF_OPT_LUA = --enable-luainterp

```

3. Build and install

```
make reconfig -j <num-jobs>
(sudo) make install

# Clean
# make distclean
```

# Dockerfile

```bash
docker build . --build-arg ip=<ip> --network host
```

# Aider

- `.aider.conf.yml` and `.aider.model.settings.yml` remain in this repository under `dev/dotfiles/`.

Usage:

```bash
cd ~
ln -s dev/dotfiles/.aider.conf.yml .
ln -s dev/dotfiles/.aider.model.settings.yml .

export GITHUB_COPILOT_TOKEN=<github-oauth-token>
```

# Codex historical token usage

[`tools/codex_usage.py`](tools/codex_usage.py) provides the `codex-usage` command.
It uses Python 3's standard library and reads Codex's local SQLite database in
read-only mode. It does not start a model request or require an API key.

Install from this repository:

```bash
chmod +x /mnt/d/utils/dev/tools/codex_usage.py
mkdir -p ~/.local/bin
ln -s /mnt/d/utils/dev/tools/codex_usage.py ~/.local/bin/codex-usage
```

Ensure `~/.local/bin` is on `PATH`. If a command already exists at the destination,
inspect it before replacing it.

```bash
codex-usage                        # Latest 20 sessions and total across all matching sessions
codex-usage -h                     # Human-readable Thousand, Million, Billion, Trillion
codex-usage --help                 # Command help
codex-usage --limit 0              # All recorded sessions
codex-usage --cwd /home/zhaoyilun/xq --limit 0
codex-usage --session SESSION_ID
codex-usage --json > codex-usage.json
codex-usage --codex-home ~/.codex
codex-usage --db ~/.codex/state_5.sqlite
```

The project filter matches the stored directory exactly. It does not include
subdirectories automatically. JSON timestamps are Unix seconds; text output uses
the machine's local timezone and includes its UTC offset.

The command lists `threads.tokens_used` as recorded by Codex, including archived
sessions still present in the database. The total sums recorded counters across all sessions matching the project and
session filters, regardless of `--limit`. Missing counters are excluded from the
sum and reported as unknown. An empty selection has a total of zero.
`-h` uses decimal units and rounds to two decimal places; `--help` shows help.
JSON always preserves exact integer token counts, including when `-h` is supplied.
It includes `total_tokens`, `matched_count`, and `unknown_count`; `count` refers
to displayed sessions. The command does not calculate costs. These counters are not an account billing statement or a daily usage
report. A zero counter can indicate missing usage. The last-update timestamp
indicates session activity, not when all displayed tokens were consumed. Deleted,
remote-only, or other machines' sessions may be absent. Forked sessions may share
history; adding counters is not guaranteed to produce distinct billed usage.

The default data directory is `CODEX_HOME`, falling back to `~/.codex`. The script
selects the highest numeric `state_*.sqlite` version and validates the required
columns. An incompatible schema causes an explicit error rather than silently
reading an older database. This is an internal Codex format, verified locally
with Codex CLI 0.154.0, and may change after upgrades. This command does not parse
JSONL events or provide input, cached-input, output, or reasoning breakdowns.

Official alternatives: use `/status` in an interactive session, or capture
`turn.completed.usage` from `codex exec --json` for future automation runs.
See [developer commands](https://learn.chatgpt.com/docs/developer-commands?surface=cli)
and [non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode).

Run offline checks:

```bash
python3 -m unittest discover -s dev/tools -p 'test_codex_usage.py' -v
```
