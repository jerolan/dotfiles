# setup fnm
eval "$(fnm env)"

# setup github copilot
eval "$(github-copilot-cli alias -- "$0")"

# bun completions
[ -s "/Users/42430/.bun/_bun" ] && source "/Users/42430/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
