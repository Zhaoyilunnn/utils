#!/usr/bin/env bash
set -euo pipefail

NVIM_VERSION="${NVIM_VERSION:-0.12.1}"
FD_VERSION="${FD_VERSION:-10.4.2}"
RG_VERSION="${RG_VERSION:-15.1.0}"
FZF_VERSION="${FZF_VERSION:-0.71.0}"
TREE_SITTER_VERSION="${TREE_SITTER_VERSION:-0.26.8}"
LUA_VERSION="${LUA_VERSION:-5.1.5}"
LUAROCKS_VERSION="${LUAROCKS_VERSION:-3.11.1}"

APT_INSTALL="${APT_INSTALL:-1}"

LOCAL_PREFIX="$HOME/.local"
LOCAL_BIN="$LOCAL_PREFIX/bin"
LOCAL_OPT="$LOCAL_PREFIX/opt"
LOCAL_SRC="$LOCAL_PREFIX/src"
LOCAL_ETC="$LOCAL_PREFIX/etc"

export PATH="$LOCAL_BIN:$PATH"

log() {
  printf '\n==> %s\n' "$1"
}

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

run_as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

require_base_commands() {
  local command_name
  for command_name in curl tar unzip make gcc dpkg; do
    need_cmd "$command_name" || fail "missing required command: $command_name"
  done
}

prepare_dirs() {
  mkdir -p "$LOCAL_BIN" "$LOCAL_OPT" "$LOCAL_SRC" "$LOCAL_ETC"
}

install_apt_base_deps() {
  if [ "$APT_INSTALL" != "1" ]; then
    log "Skipping apt dependencies because APT_INSTALL=$APT_INSTALL"
    return
  fi

  need_cmd sudo || [ "$(id -u)" -eq 0 ] || fail "sudo is required when APT_INSTALL=1"

  log "Installing minimal system dependencies"
  run_as_root apt-get update
  run_as_root apt-get install -y \
    ca-certificates \
    curl \
    git \
    tar \
    gzip \
    xz-utils \
    unzip \
    build-essential \
    libreadline-dev \
    libncurses-dev \
    xclip \
    wl-clipboard
}

download() {
  local url="$1"
  local output="$2"

  curl -fL --retry 3 --retry-delay 2 --connect-timeout 15 "$url" -o "$output"
}

extract_single_root_tarball() {
  local archive="$1"
  local destination="$2"
  local temp_dir root_dir

  temp_dir="$(mktemp -d)"
  tar -C "$temp_dir" -xzf "$archive"
  root_dir="$(find "$temp_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
  [ -n "$root_dir" ] || fail "failed to find extracted directory in $archive"

  rm -rf "$destination"
  mkdir -p "$(dirname "$destination")"
  mv "$root_dir" "$destination"
  rm -rf "$temp_dir"
}

linux_arch() {
  case "$(dpkg --print-architecture)" in
    amd64) echo "x86_64" ;;
    arm64) echo "arm64" ;;
    *) fail "unsupported architecture: $(dpkg --print-architecture)" ;;
  esac
}

fd_target() {
  case "$(dpkg --print-architecture)" in
    amd64) echo "x86_64-unknown-linux-gnu" ;;
    arm64) echo "aarch64-unknown-linux-gnu" ;;
    *) fail "unsupported architecture: $(dpkg --print-architecture)" ;;
  esac
}

rg_target() {
  case "$(dpkg --print-architecture)" in
    # ripgrep currently publishes a musl tarball for x86_64 Linux
    # and a gnu tarball for aarch64 Linux.
    amd64) echo "x86_64-unknown-linux-musl" ;;
    arm64) echo "aarch64-unknown-linux-gnu" ;;
    *) fail "unsupported architecture: $(dpkg --print-architecture)" ;;
  esac
}

fzf_target() {
  case "$(dpkg --print-architecture)" in
    amd64) echo "linux_amd64" ;;
    arm64) echo "linux_arm64" ;;
    *) fail "unsupported architecture: $(dpkg --print-architecture)" ;;
  esac
}

tree_sitter_target() {
  case "$(dpkg --print-architecture)" in
    amd64) echo "linux-x64" ;;
    arm64) echo "linux-arm64" ;;
    *) fail "unsupported architecture: $(dpkg --print-architecture)" ;;
  esac
}

install_neovim() {
  local arch url archive_name archive_path destination

  arch="$(linux_arch)"
  archive_name="nvim-linux-${arch}.tar.gz"
  archive_path="/tmp/${archive_name}"
  url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${archive_name}"
  destination="$LOCAL_OPT/nvim-v${NVIM_VERSION}-linux-${arch}"

  log "Installing Neovim v${NVIM_VERSION} into ~/.local"
  download "$url" "$archive_path"
  extract_single_root_tarball "$archive_path" "$destination"
  ln -sf "$destination/bin/nvim" "$LOCAL_BIN/nvim"
}

install_fd() {
  local target archive_name archive_path url destination

  target="$(fd_target)"
  archive_name="fd-v${FD_VERSION}-${target}.tar.gz"
  archive_path="/tmp/${archive_name}"
  url="https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/${archive_name}"
  destination="$LOCAL_OPT/fd-v${FD_VERSION}-${target}"

  log "Installing fd v${FD_VERSION} into ~/.local"
  download "$url" "$archive_path"
  extract_single_root_tarball "$archive_path" "$destination"
  ln -sf "$destination/fd" "$LOCAL_BIN/fd"
}

install_ripgrep() {
  local target archive_name archive_path url destination

  target="$(rg_target)"
  archive_name="ripgrep-${RG_VERSION}-${target}.tar.gz"
  archive_path="/tmp/${archive_name}"
  url="https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${archive_name}"
  destination="$LOCAL_OPT/ripgrep-${RG_VERSION}-${target}"

  log "Installing ripgrep ${RG_VERSION} into ~/.local"
  download "$url" "$archive_path"
  extract_single_root_tarball "$archive_path" "$destination"
  ln -sf "$destination/rg" "$LOCAL_BIN/rg"
}

install_fzf() {
  local target archive_name archive_path url destination temp_dir

  target="$(fzf_target)"
  archive_name="fzf-${FZF_VERSION}-${target}.tar.gz"
  archive_path="/tmp/${archive_name}"
  url="https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${archive_name}"
  destination="$LOCAL_OPT/fzf-${FZF_VERSION}-${target}"
  temp_dir="$(mktemp -d)"

  log "Installing fzf ${FZF_VERSION} into ~/.local"
  download "$url" "$archive_path"
  tar -C "$temp_dir" -xzf "$archive_path"
  rm -rf "$destination"
  mkdir -p "$destination/bin"
  install -m 0755 "$temp_dir/fzf" "$destination/bin/fzf"
  ln -sf "$destination/bin/fzf" "$LOCAL_BIN/fzf"
  rm -rf "$temp_dir"
}

install_tree_sitter() {
  local target archive_name archive_path url destination temp_dir

  target="$(tree_sitter_target)"
  archive_name="tree-sitter-cli-${target}.zip"
  archive_path="/tmp/${archive_name}"
  url="https://github.com/tree-sitter/tree-sitter/releases/download/v${TREE_SITTER_VERSION}/${archive_name}"
  destination="$LOCAL_OPT/tree-sitter-v${TREE_SITTER_VERSION}-${target}"
  temp_dir="$(mktemp -d)"

  log "Installing tree-sitter ${TREE_SITTER_VERSION} into ~/.local"
  download "$url" "$archive_path"
  unzip -q "$archive_path" -d "$temp_dir"
  rm -rf "$destination"
  mkdir -p "$destination/bin"
  install -m 0755 "$temp_dir/tree-sitter" "$destination/bin/tree-sitter"
  ln -sf "$destination/bin/tree-sitter" "$LOCAL_BIN/tree-sitter"
  rm -rf "$temp_dir"
}

install_lua() {
  local archive_name archive_path url source_dir

  archive_name="lua-${LUA_VERSION}.tar.gz"
  archive_path="/tmp/${archive_name}"
  url="https://www.lua.org/ftp/${archive_name}"
  source_dir="$LOCAL_SRC/lua-${LUA_VERSION}"

  log "Building Lua ${LUA_VERSION} into ~/.local"
  download "$url" "$archive_path"
  rm -rf "$source_dir"
  tar -C "$LOCAL_SRC" -xzf "$archive_path"
  make -C "$source_dir" clean >/dev/null 2>&1 || true
  make -C "$source_dir" linux
  make -C "$source_dir" install INSTALL_TOP="$LOCAL_PREFIX"
}

install_luarocks() {
  local archive_name archive_path url source_dir

  archive_name="luarocks-${LUAROCKS_VERSION}.tar.gz"
  archive_path="/tmp/${archive_name}"
  url="https://luarocks.org/releases/${archive_name}"
  source_dir="$LOCAL_SRC/luarocks-${LUAROCKS_VERSION}"

  log "Building LuaRocks ${LUAROCKS_VERSION} into ~/.local"
  download "$url" "$archive_path"
  rm -rf "$source_dir"
  tar -C "$LOCAL_SRC" -xzf "$archive_path"

  (
    cd "$source_dir"
    ./configure \
      --prefix="$LOCAL_PREFIX" \
      --sysconfdir="$LOCAL_ETC/luarocks" \
      --rocks-tree="$LOCAL_PREFIX" \
      --with-lua="$LOCAL_PREFIX" \
      --with-lua-bin="$LOCAL_BIN" \
      --with-lua-include="$LOCAL_PREFIX/include" \
      --with-lua-lib="$LOCAL_PREFIX/lib" \
      --lua-version=5.1
    make
    make install
  )
}

verify_installation() {
  log "Verifying installation"

  git --version
  nvim --version | head -n 1
  fd --version
  rg --version | head -n 1
  fzf --version
  tree-sitter --version
  lua -v
  luac -v
  luarocks --version | head -n 1

  printf '\n'
  printf 'nvim        %s\n' "$(command -v nvim)"
  printf 'fd          %s\n' "$(command -v fd)"
  printf 'rg          %s\n' "$(command -v rg)"
  printf 'fzf         %s\n' "$(command -v fzf)"
  printf 'tree-sitter %s\n' "$(command -v tree-sitter)"
  printf 'lua         %s\n' "$(command -v lua)"
  printf 'luarocks    %s\n' "$(command -v luarocks)"
}

main() {
  prepare_dirs
  install_apt_base_deps
  require_base_commands

  install_neovim
  install_fd
  install_ripgrep
  install_fzf
  install_tree_sitter
  install_lua
  install_luarocks
  verify_installation

  cat <<EOF

Done.

System packages installed:
  - ca-certificates
  - curl
  - git
  - tar / gzip / xz-utils / unzip
  - build-essential
  - libreadline-dev / libncurses-dev
  - xclip / wl-clipboard

Installed under ~/.local:
  - Neovim v${NVIM_VERSION}
  - fd v${FD_VERSION}
  - ripgrep ${RG_VERSION}
  - fzf ${FZF_VERSION}
  - tree-sitter ${TREE_SITTER_VERSION}
  - Lua ${LUA_VERSION}
  - LuaRocks ${LUAROCKS_VERSION}

Not touched:
  - ~/.config/nvim
  - ~/.local/share/nvim
  - ~/.local/state/nvim
  - ~/.cache/nvim

Make sure your shell PATH contains:
  export PATH="\$HOME/.local/bin:\$PATH"

Optional:
  - Skip apt step: APT_INSTALL=0 bash $0
  - Pin another Neovim: NVIM_VERSION=0.12.1 bash $0
EOF
}

main "$@"
