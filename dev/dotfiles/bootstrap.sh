#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

chezmoi init --source "$REPO_DIR"
chezmoi apply
