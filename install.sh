#!/usr/bin/env bash

# Get current dir

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles

if [[ -x 'git -a -d "$DOTFILES_DIR/.git"' ]]
  then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master
fi

# Symlink all the dotfiles

ln -sfv "$DOTFILES_DIR/.ackrc" ~
ln -sfv "$DOTFILES_DIR/.agignore" ~
ln -sfv "$DOTFILES_DIR/.aliases" ~
ln -sfv "$DOTFILES_DIR/.asdfrc" ~
ln -sfv "$DOTFILES_DIR/.ctags" ~
ln -sfv "$DOTFILES_DIR/.curlrc" ~
ln -sfv "$DOTFILES_DIR/.default-gems" ~
ln -sfv "$DOTFILES_DIR/.editorconfig" ~
ln -sfv "$DOTFILES_DIR/.gemrc" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/.gitmessage" ~
ln -sfv "$DOTFILES_DIR/.irbrc" ~
ln -sfv "$DOTFILES_DIR/.prettierrc.toml" ~
ln -sfv "$DOTFILES_DIR/.pryrc" ~
ln -sfv "$DOTFILES_DIR/.psqlrc" ~
ln -sfv "$DOTFILES_DIR/.rspec" ~
ln -sfv "$DOTFILES_DIR/.tmux.conf" ~
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
mkdir -p ~/.config && ln -sfv "$DOTFILES_DIR/starship.toml" ~/.config
mkdir -p ~/.vim && ln -sfv "$DOTFILES_DIR/coc-settings.json" ~/.vim
mkdir -p ~/.config/bat && ln -sfv "$DOTFILES_DIR/bat-config" ~/.config/bat/config
mkdir -p ~/.nixpkgs && ln -sfv "$DOTFILES_DIR/darwin-configuration.nix" ~/.nixpkgs
