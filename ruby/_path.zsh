export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# Load rbenv automatically by appending
# the following to ~/.zshrc:
eval "$(rbenv init -)"
