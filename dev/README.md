# neovim

The Neovim configuration is in the `dotfiles/.config/nvim` directory.  
To use it, link the configuration to your system's Neovim config path:

```bash
ln -s dev/dotfiles/.config/nvim ~/.config/nvim
```

# Vim

The current version of `.vimrc` is in the `dotfiles` directory and aims for vim>=9.0 (although it runs correctly on vim<9.0 now).

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

- `.aider.conf.yml`: Aider configuration file (in `dotfiles`).
- `.aider.model.settings.yml`: Aider model settings file (in `dotfiles`).

Usage:

```bash
cd ~
ln -s dev/dotfiles/.aider.conf.yml .
ln -s dev/dotfiles/.aider.model.settings.yml .

export GITHUB_COPILOT_TOKEN=<github-oauth-token>
```
