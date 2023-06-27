# setup fnm
eval "$(fnm env)"

# setup github copilot
eval "$(npx github-copilot-cli alias -- "$0")"
