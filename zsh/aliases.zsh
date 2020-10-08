alias hyperc="vim ~/.dotfiles/hyper/hyper.js"
alias zshrc="vim ~/.dotfiles/zsh/zshrc"
alias brew_outdated_all="echo 'updating brew' && \
	brew update && \
	echo 'brew outdated lisk' && \
	brew outdated && \
	echo 'brew outdated --cask' && \
	brew cask outdated && \
	echo 'mas outdated lisk' && \
	mas outdated"
alias brew_upgrade_all="echo 'upgrade brew' && \
	brew upgrade && \
	echo 'cask upgrade' && \
	brew cask upgrade && \
	echo 'mas upgrade' && \
	mas upgrade"
