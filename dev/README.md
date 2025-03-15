# neovim

Just link to your system's neovim configuration directory.

```bash
ln -s nvim ~/.config/nvim
```

# Vim

Current version of `.vimrc` aims for vim>=9.0 (although it runs correctly on vim<9.0 now).

In the future, I plan to add some configurations that may only work on vim>=9.0

For example, the [`catppuccin`](https://github.com/catppuccin/nvim) plugin only support 9.0+ with lua compilation.

My older config for vim==8.2 can be found in `tags/v0.1.0`

## Latex

- [How I'm able to take notes in mathematics lectures using LaTeX and Vim](https://castel.dev/post/lecture-notes-1/)
- [latex-snippets](https://github.com/gillescastel/latex-snippets)

## Build Vim From Source

Building vim is simple. But you need read the instructions with its code repository.

A sample workflow is

1. clone the repository

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

3. Buid and install

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
