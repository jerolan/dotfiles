# Homebrew installs git's completion here; load it only if brew is present.
if command -v brew >/dev/null 2>&1; then
  completion="$(brew --prefix)/share/zsh/site-functions/_git"
  [ -f "$completion" ] && source "$completion"
fi
