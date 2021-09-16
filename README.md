# Jerome's dotfiles

A fork from [holman/dotfiles](https://github.com/holman/dotfiles)

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in bin/ will get added to your $PATH and be made available everywhere.
- **topic/\_.zsh**: Any files ending in .zsh get loaded into your environment.
- **topic/path.zsh**: Any file named path.zsh is loaded first and is expected to setup $PATH or similar.
- **topic/completion.zsh**: Any file named completion.zsh is loaded last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named install.sh is executed when you run script/install. To avoid being loaded automatically, its extension is .sh, not .zsh.
- **topic/\_.symlink**: Any file ending in \*.symlink gets symlinked into your $HOME. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run script/bootstrap.

## Install

Run this:

```sh
git clone https://github.com/jerolan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
