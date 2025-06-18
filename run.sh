set -e

# find the installers and run them iteratively
find . -name install.sh | while read installer; do sh -c "${installer}"; done

brew tap Homebrew/bundle
brew bundle

# Link System files
ln -sf $PWD/git/gitignore ~/.gitignore
ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/hyper/hyper.js ~/.hyper.js
ln -sf $PWD/zsh/zshrc ~/.zshrc
