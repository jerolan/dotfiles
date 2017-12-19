# GRC colorizes nifty unix tools all over the place
#
# grc.bashrc is normally located in `brew --prefix`/etc/, but a
# change in the GRC project started using `type -p` instead of
# `which` to find the location of GRC. This causes errors because
# of OSX's strange output from `type -p grc`.
# See: https://github.com/garabik/grc/issues/54
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  source $HOME/.dotfiles/grc/grc.bashrc
fi