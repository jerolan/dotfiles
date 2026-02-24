#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# All installers run once, then we link dotfiles and finish with post-installs.

run_installer() {
  local installer="$1"
  if [[ -f "$installer" ]]; then
    sh "$installer"
  fi
}

run_installer "$ROOT_DIR/homebrew/install.sh"  # ensures brew exists before anything else

if ! command -v brew >/dev/null 2>&1; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

run_installer "$ROOT_DIR/macos/install.sh"   # macOS updates + one-time defaults
run_installer "$ROOT_DIR/node/install.sh"    # node tooling managers
run_installer "$ROOT_DIR/dotnet/install.sh"  # dotnet runtime helper

if command -v brew >/dev/null 2>&1; then
  (cd "$ROOT_DIR" && brew bundle)             # installs everything declared in Brewfile
fi

ln -sf "$ROOT_DIR/git/gitignore" "$HOME/.gitignore"
ln -sf "$ROOT_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$ROOT_DIR/hyper/hyper.js" "$HOME/.hyper.js"
ln -sf "$ROOT_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$ROOT_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
ln -sf "$ROOT_DIR/code/mcp.json" "$HOME/Library/Application Support/Code/User/mcp.json"
ln -sf "$ROOT_DIR/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
ln -s "$ROOT_DIR/agents" "$HOME/.agents"

run_installer "$ROOT_DIR/node/post-install.sh"
