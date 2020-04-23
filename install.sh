brew tap Homebrew/bundle
brew tap caskroom/versions
brew bundle

mkdir ~/.config/mvim

# Link System files
ln -sf $PWD/vim/nvimrc ~/.config/nvim/init.vim
ln -sf $PWD/git/gitignore ~/.gitignore
ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/gradle/gradle.properties ~/.gradle/gradle.properties
ln -sf $PWD/hyper/hyper.js ~/.hyper.js
ln -sf $PWD/zsh/zshrc ~/.zshrc
# ln -sf $PWD/node/nvmrc ~/.nvmrc

# Install python virtualenv
pip install virtualenv

# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
