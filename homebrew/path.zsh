# Detect the architecture
ARCHITECTURE=$(uname -m)

# Check and set up Homebrew environment based on architecture
if [ "$ARCHITECTURE" = "arm64" ]; then
    # Check if the Homebrew path for arm64 exists
    if [ -f "/opt/homebrew/bin/brew" ]; then
        echo "Setting up Homebrew for arm64 architecture."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "Homebrew not found at /opt/homebrew/bin/brew for arm64."
    fi
else
    # Check if the Homebrew path for Intel architecture exists
    if [ -f "/usr/local/bin/brew" ]; then
        echo "Setting up Homebrew for Intel architecture."
        eval "$(/usr/local/bin/brew shellenv)"
    else
        echo "Homebrew not found at /usr/local/bin/brew for Intel architecture."
    fi
fi
