#!/bin/sh

if command -v brew >/dev/null 2>&1; then
  exit 0
fi

OS="$(uname)"
if [ "$OS" = "Darwin" ] || [ "$OS" = "Linux" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

exit 0
