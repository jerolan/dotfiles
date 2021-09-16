brew tap Homebrew/bundle
brew bundle

mkdir ~/.config/mvim

# Link System files
ln -sf $PWD/vim/nvimrc ~/.config/nvim/init.vim
ln -sf $PWD/git/gitignore ~/.gitignore
ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/gradle/gradle.properties ~/.gradle/gradle.properties
ln -sf $PWD/hyper/hyper.js ~/.hyper.js
ln -sf $PWD/zsh/zshrc ~/.zshrc

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh

# Install python virtualenv
pip install virtualenv

# Install go version manager
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# # TODO
# # Run all dotfiles installers.

# set -e

# cd "$(dirname $0)"/..

# # find the installers and run them iteratively
# find . -name install.sh | while read installer ; do sh -c "${installer}" ; done
