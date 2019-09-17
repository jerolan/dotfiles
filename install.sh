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
ln -sf $PWD/nvm/nvmrc ~/.nvmrc

# Install python virtualenv
pip install virtualenv

# Install rvm
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | zsh -s stable

# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
