# GRC colorizes CLI output; load it only if Homebrew provides it.
if command -v brew >/dev/null 2>&1; then
  grc_file="$(brew --prefix)/etc/grc.zsh"
  [ -r "$grc_file" ] && source "$grc_file"
fi
