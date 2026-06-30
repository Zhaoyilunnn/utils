#!/bin/sh
set -eu

{
  # 预设的保底版本（当网络异常无法请求到 GitHub 的最新版本时回退到这里）
  FALLBACK_NVIM="0.12.1"
  FALLBACK_FD="10.4.2"
  FALLBACK_RG="15.1.0"
  FALLBACK_FZF="0.71.0"
  FALLBACK_TREE_SITTER="0.26.8"
  FALLBACK_LUAROCKS="3.11.1"

  # Lua 对于 Neovim 配置来说 5.1.x 是最推荐的基线环境，除非有特殊情况一般不拉取最新大版本
  LUA_VERSION="${LUA_VERSION:-5.1.5}"

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

  version_ge() {
    [ "$1" = "$2" ] || [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n 1)" = "$2" ]
  }

  extract_version() {
    grep -Eo '[0-9]+([.][0-9]+)+' | head -n 1 || true
  }

  # 动态获取 GitHub 的最新 Release 版本号
  get_latest_release() {
    local repo="$1"
    local fallback="$2"
    local version=""

    # 1. 尝试使用 GitHub API 获取（添加 --max-time 防止卡死）
    version="$(curl -fsSL --max-time 5 "https://api.github.com/repos/$repo/releases/latest" 2>/dev/null | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//' || true)"

    if [ -z "$version" ]; then
      # 2. 如果因为请求限制 API 失败，降级通过 Location 跳转拉取 tag 信息
      version="$(curl -fsS -I --max-time 5 "https://github.com/$repo/releases/latest" 2>/dev/null | grep -i '^location:' | head -n 1 | tr -d '\r' | awk -F'/' '{print $NF}' | sed 's/^v//' || true)"
    fi

    if [ -z "$version" ]; then
      version="$fallback"
    fi

    printf "%s\n" "$version"
  }

  installed_executable_at_least() {
    local name="$1"
    local path="$2"
    local minimum_version="$3"
    local installed_version

    [ -x "$path" ] || return 1

    installed_version="$("$path" --version 2>&1 | extract_version)"
    [ -n "$installed_version" ] || return 1

    if version_ge "$installed_version" "$minimum_version"; then
      log "Skipping ${name}; installed version ${installed_version} at ${path} is >= ${minimum_version}"
      return 0
    fi

    return 1
  }

  installed_command_at_least() {
    local name="$1"
    local command_name="$2"
    local minimum_version="$3"
    local path

    path="$(command -v "$command_name" || true)"
    [ -n "$path" ] || return 1

    installed_executable_at_least "$name" "$path" "$minimum_version"
  }

  installed_lua_at_least() {
    local lua_path luac_path installed_version

    lua_path="$(command -v lua || true)"
    luac_path="$(command -v luac || true)"
    if [ -z "$lua_path" ] || [ -z "$luac_path" ]; then
      return 1
    fi

    installed_version="$("$lua_path" -v 2>&1 | extract_version)"
    [ -n "$installed_version" ] || return 1

    if version_ge "$installed_version" "$LUA_VERSION"; then
      log "Skipping Lua; installed version ${installed_version} at ${lua_path} is >= ${LUA_VERSION}"
      return 0
    fi

    return 1
  }

  apt_package_installed() {
    [ "$(dpkg-query -W -f='${Status}' "$1" 2>/dev/null || true)" = "install ok installed" ]
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
    local packages missing pkg

    if [ "$APT_INSTALL" != "1" ]; then
      log "Skipping apt dependencies because APT_INSTALL=$APT_INSTALL"
      return
    fi

    packages="ca-certificates curl git tar gzip xz-utils unzip build-essential libreadline-dev libncurses-dev xclip wl-clipboard"
    missing=""

    for pkg in $packages; do
      if ! apt_package_installed "$pkg"; then
        missing="$missing $pkg"
      fi
    done

    # 清除前导空格
    missing="${missing# }"

    if [ -z "$missing" ]; then
      log "System apt dependencies already installed"
      return
    fi

    need_cmd sudo || [ "$(id -u)" -eq 0 ] || fail "sudo is required when APT_INSTALL=1"

    log "Installing missing system dependencies: $missing"
    run_as_root apt-get update
    # 这里的自动分词是预期的，所以忽略 shellcheck
    # shellcheck disable=SC2086
    run_as_root apt-get install -y $missing
  }

  resolve_versions() {
    log "Resolving latest tool versions..."
    NVIM_VERSION="${NVIM_VERSION:-$(get_latest_release "neovim/neovim" "$FALLBACK_NVIM")}"
    FD_VERSION="${FD_VERSION:-$(get_latest_release "sharkdp/fd" "$FALLBACK_FD")}"
    RG_VERSION="${RG_VERSION:-$(get_latest_release "BurntSushi/ripgrep" "$FALLBACK_RG")}"
    FZF_VERSION="${FZF_VERSION:-$(get_latest_release "junegunn/fzf" "$FALLBACK_FZF")}"
    TREE_SITTER_VERSION="${TREE_SITTER_VERSION:-$(get_latest_release "tree-sitter/tree-sitter" "$FALLBACK_TREE_SITTER")}"
    LUAROCKS_VERSION="${LUAROCKS_VERSION:-$(get_latest_release "luarocks/luarocks" "$FALLBACK_LUAROCKS")}"

    log "Versions to install (>= current):"
    log "  Neovim:      $NVIM_VERSION"
    log "  fd:          $FD_VERSION"
    log "  ripgrep:     $RG_VERSION"
    log "  fzf:         $FZF_VERSION"
    log "  tree-sitter: $TREE_SITTER_VERSION"
    log "  LuaRocks:    $LUAROCKS_VERSION"
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
    if [ -z "$root_dir" ]; then
      fail "failed to find extracted directory in $archive"
    fi

    rm -rf "$destination"
    mkdir -p "$(dirname "$destination")"
    mv "$root_dir" "$destination"
    rm -rf "$temp_dir"
  }

  linux_arch() {
    case "$(uname -m)" in
      x86_64|amd64) echo "x86_64" ;;
      aarch64|arm64) echo "arm64" ;;
      *) fail "unsupported architecture: $(uname -m)" ;;
    esac
  }

  fd_target() {
    case "$(uname -m)" in
      x86_64|amd64) echo "x86_64-unknown-linux-gnu" ;;
      aarch64|arm64) echo "aarch64-unknown-linux-gnu" ;;
      *) fail "unsupported architecture: $(uname -m)" ;;
    esac
  }

  rg_target() {
    case "$(uname -m)" in
      x86_64|amd64) echo "x86_64-unknown-linux-musl" ;;
      aarch64|arm64) echo "aarch64-unknown-linux-gnu" ;;
      *) fail "unsupported architecture: $(uname -m)" ;;
    esac
  }

  fzf_target() {
    case "$(uname -m)" in
      x86_64|amd64) echo "linux_amd64" ;;
      aarch64|arm64) echo "linux_arm64" ;;
      *) fail "unsupported architecture: $(uname -m)" ;;
    esac
  }

  tree_sitter_target() {
    case "$(uname -m)" in
      x86_64|amd64) echo "linux-x64" ;;
      aarch64|arm64) echo "linux-arm64" ;;
      *) fail "unsupported architecture: $(uname -m)" ;;
    esac
  }

  install_neovim() {
    local arch url archive_name archive_path destination

    arch="$(linux_arch)"
    archive_name="nvim-linux-${arch}.tar.gz"
    archive_path="/tmp/${archive_name}"
    url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${archive_name}"
    destination="$LOCAL_OPT/nvim-v${NVIM_VERSION}-linux-${arch}"

    installed_command_at_least "Neovim" "nvim" "$NVIM_VERSION" && return
    installed_executable_at_least "Neovim" "$destination/bin/nvim" "$NVIM_VERSION" && {
      ln -sf "$destination/bin/nvim" "$LOCAL_BIN/nvim"
      return
    }

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

    installed_command_at_least "fd" "fd" "$FD_VERSION" && return
    installed_executable_at_least "fd" "$destination/fd" "$FD_VERSION" && {
      ln -sf "$destination/fd" "$LOCAL_BIN/fd"
      return
    }

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

    installed_command_at_least "ripgrep" "rg" "$RG_VERSION" && return
    installed_executable_at_least "ripgrep" "$destination/rg" "$RG_VERSION" && {
      ln -sf "$destination/rg" "$LOCAL_BIN/rg"
      return
    }

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

    installed_command_at_least "fzf" "fzf" "$FZF_VERSION" && return
    installed_executable_at_least "fzf" "$destination/bin/fzf" "$FZF_VERSION" && {
      ln -sf "$destination/bin/fzf" "$LOCAL_BIN/fzf"
      return
    }

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
    local target destination

    target="$(tree_sitter_target)"
    destination="$LOCAL_OPT/tree-sitter-v${TREE_SITTER_VERSION}-${target}"

    installed_command_at_least "tree-sitter" "tree-sitter" "$TREE_SITTER_VERSION" && return
    installed_executable_at_least "tree-sitter" "$destination/bin/tree-sitter" "$TREE_SITTER_VERSION" && {
      ln -sf "$destination/bin/tree-sitter" "$LOCAL_BIN/tree-sitter"
      return
    }

    log "Installing tree-sitter ${TREE_SITTER_VERSION} into ~/.local"

    # 较新的版本部分提供 .gz 单文件或打包为了 .zip，我们采用降级拉取法双重保障
    local target_gz="tree-sitter-${target}.gz"
    local target_zip="tree-sitter-cli-${target}.zip"
    local url_gz="https://github.com/tree-sitter/tree-sitter/releases/download/v${TREE_SITTER_VERSION}/${target_gz}"
    local url_zip="https://github.com/tree-sitter/tree-sitter/releases/download/v${TREE_SITTER_VERSION}/${target_zip}"

    rm -rf "$destination"
    mkdir -p "$destination/bin"
    local temp_dir
    temp_dir="$(mktemp -d)"

    if curl -fL --retry 3 -sS "$url_gz" -o "$temp_dir/$target_gz" 2>/dev/null; then
      gzip -dc "$temp_dir/$target_gz" > "$destination/bin/tree-sitter"
    elif curl -fL --retry 3 -sS "$url_zip" -o "$temp_dir/$target_zip" 2>/dev/null; then
      unzip -q "$temp_dir/$target_zip" -d "$temp_dir"
      mv "$temp_dir/tree-sitter" "$destination/bin/tree-sitter"
    else
      rm -rf "$temp_dir" "$destination"
      fail "Failed to download tree-sitter from both .gz and .zip endpoints"
    fi

    chmod 0755 "$destination/bin/tree-sitter"
    ln -sf "$destination/bin/tree-sitter" "$LOCAL_BIN/tree-sitter"
    rm -rf "$temp_dir"
  }

  install_lua() {
    local archive_name archive_path url source_dir

    archive_name="lua-${LUA_VERSION}.tar.gz"
    archive_path="/tmp/${archive_name}"
    url="https://www.lua.org/ftp/${archive_name}"
    source_dir="$LOCAL_SRC/lua-${LUA_VERSION}"

    installed_lua_at_least && return

    log "Building Lua ${LUA_VERSION} into ~/.local"
    download "$url" "$archive_path"
    rm -rf "$source_dir"
    tar -C "$LOCAL_SRC" -xzf "$archive_path"
    make -C "$source_dir" clean >/dev/null 2>&1 || true
    make -C "$source_dir" linux
    make -C "$source_dir" install INSTALL_TOP="$LOCAL_PREFIX"
  }

  install_luarocks() {
    local archive_name archive_path url source_dir lua_bin_dir lua_version lua_abi_version

    installed_command_at_least "LuaRocks" "luarocks" "$LUAROCKS_VERSION" && return
    installed_executable_at_least "LuaRocks" "$LOCAL_BIN/luarocks" "$LUAROCKS_VERSION" && return

    archive_name="luarocks-${LUAROCKS_VERSION}.tar.gz"
    archive_path="/tmp/${archive_name}"
    url="https://luarocks.org/releases/${archive_name}"
    source_dir="$LOCAL_SRC/luarocks-${LUAROCKS_VERSION}"
    lua_bin_dir="$(dirname "$(command -v lua)")"
    lua_version="$(lua -v 2>&1 | extract_version)"
    lua_abi_version="$(printf '%s\n' "$lua_version" | cut -d. -f1,2)"
    [ -n "$lua_abi_version" ] || fail "failed to detect Lua version for LuaRocks"

    log "Building LuaRocks ${LUAROCKS_VERSION} into ~/.local"

    # 优先使用 luarocks 官网包，如果被墙或者未发布，尝试 GitHub Source Fallback
    if ! curl -fL --retry 3 -sS "$url" -o "$archive_path" 2>/dev/null; then
      url="https://github.com/luarocks/luarocks/archive/refs/tags/v${LUAROCKS_VERSION}.tar.gz"
      download "$url" "$archive_path"
    fi

    rm -rf "$source_dir"
    tar -C "$LOCAL_SRC" -xzf "$archive_path"

    (
      cd "$source_dir"
      ./configure \
        --prefix="$LOCAL_PREFIX" \
        --sysconfdir="$LOCAL_ETC/luarocks" \
        --rocks-tree="$LOCAL_PREFIX" \
        --with-lua-bin="$lua_bin_dir" \
        --lua-version="$lua_abi_version"
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

    # 网络请求基础环境就位后，动态判断需要安装的最新版版本号
    resolve_versions

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

System packages checked and installed only if missing.
Missing or outdated tools are installed under ~/.local.

Tool versions ensured (>= current releases):
  - Neovim >= ${NVIM_VERSION}
  - fd >= ${FD_VERSION}
  - ripgrep >= ${RG_VERSION}
  - fzf >= ${FZF_VERSION}
  - tree-sitter >= ${TREE_SITTER_VERSION}
  - Lua >= ${LUA_VERSION}
  - LuaRocks ${LUAROCKS_VERSION}

Make sure your shell PATH contains:
  export PATH="\$HOME/.local/bin:\$PATH"

Optional overrides:
  - Skip apt step: APT_INSTALL=0 curl -sSL <YOUR_URL> | sh
  - Pin versions: NVIM_VERSION=0.12.1 curl -sSL <YOUR_URL> | sh
EOF
  }

  main "$@"
}
