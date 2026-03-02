# Prefer adding Homebrew's zsh site-functions directory to `fpath`
# so completions are autoloaded by `compinit` instead of being sourced.
if command -v brew >/dev/null 2>&1; then
  sitefuncs="$(brew --prefix)/share/zsh/site-functions"
  if [ -d "$sitefuncs" ]; then
    fpath=("$sitefuncs" $fpath)
  fi
fi
