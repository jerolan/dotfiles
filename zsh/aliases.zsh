alias reload='. ~/.zshrc'
alias cls='clear' # Good 'ol Clear Screen command
alias dotfiles='code ~/.dotfiles'

# Prefer modern CLI replacements when available
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --color=auto --group-directories-first'
  alias ll='eza -lh --git'
  alias la='eza -lha --git'
  alias lt='eza -lha --git --tree'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never --style=plain'
fi

if command -v fd >/dev/null 2>&1; then
  # Prefer fd explicitly, but don't override find due to flag differences
  alias ff='fd'
fi

if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
fi
