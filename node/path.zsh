# fnm: ensure its bin is on PATH and activate shim env
if [ -x /opt/homebrew/opt/fnm/bin/fnm ]; then
  eval "$('/opt/homebrew/opt/fnm/bin/fnm' env --use-on-cd)"
elif [ -x "$HOME/.fnm/fnm" ]; then
  eval "$("$HOME/.fnm/fnm" env --use-on-cd)"
fi

# bun: add to PATH if installed
if [ -d "$HOME/.bun/bin" ]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi
