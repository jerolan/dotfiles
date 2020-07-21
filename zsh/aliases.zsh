alias hyperc="vim ~/.dotfiles/hyper/hyper.js"
alias zshrc="vim ~/.dotfiles/zsh/zshrc"
alias brew_outdated_all="echo 'updating brew' && \
	brew update && \
	echo 'brew outdated lisk' && \
	brew outdated && \
	echo 'cask outdated lisk' && \
	brew cask outdated && \
	echo 'mas outdated lisk' && \
	mas outdated"
