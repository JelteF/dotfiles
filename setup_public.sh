#!/bin/bash

BACKUP_DIR=$PWD/backup
ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_PROFILE=$HOME/.profile
ORIGINAL_GITCONFIG=$HOME/.gitconfig
ORIGINAL_TMUXCONF=$HOME/.tmux.conf
ORIGINAL_VIMRC=$HOME/.vimrc
ORIGINAL_XCOMPOSE=$HOME/.XCompose

# Backup current dotfiles
mkdir -p $BACKUP_DIR
mv $ORIGINAL_BASHRC $ORIGINAL_BASH_PROFILE $ORIGINAL_PROFILE \
    $ORIGINAL_GITCONFIG $ORIGINAL_TMUXCONF $ORIGINAL_VIMRC \
    $ORIGINAL_XCOMPOSE $BACKUP_DIR

# Create vim folders
mkdir ~/.vim
mkdir ~/.vim/bundle
mkdir ~/.vim/colors

# Install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install nice color scheme
wget https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Bright.vim -O ~/.vim/colors/Tomorrow-Night-Bright.vim

ln -s $PWD/bash/bashrc $ORIGINAL_BASHRC
ln -s $PWD/bash/profile $ORIGINAL_PROFILE
ln -s $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -s $PWD/tmux/tmux.conf $ORIGINAL_TMUXCONF
ln -s $PWD/vim/vimrc_public $ORIGINAL_VIMRC
ln -s $PWD/x/XCompose $ORIGINAL_XCOMPOSE
