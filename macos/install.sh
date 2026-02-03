if test ! "$(uname)" = "Darwin"; then
  exit 0
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/tweaks.sh" ]; then
  sh "$SCRIPT_DIR/tweaks.sh"
fi
