set -e

# find the installers and run them iteratively
find . -name install.sh | while read installer; do sh -c "${installer}"; done

brew tap Homebrew/bundle

# Install the correct homebrew for each OS type
if test "$(uname)" = "Darwin"; then
  brew bundle
elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
  brew bundle --file=Brewfile.linux
fi

mkdir ~/.config/mvim

# Link System files
ln -sf $PWD/vim/nvimrc ~/.config/nvim/init.vim
ln -sf $PWD/git/gitignore ~/.gitignore
ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/gradle/gradle.properties ~/.gradle/gradle.properties
ln -sf $PWD/hyper/hyper.js ~/.hyper.js
ln -sf $PWD/zsh/zshrc ~/.zshrc
