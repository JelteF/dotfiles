#!/bin/bash

BACKUP_DIR=$PWD/backup
ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_BASH_PROFILE=$HOME/.bash_profile
ORIGINAL_PROFILE=$HOME/.profile
ORIGINAL_GITCONFIG=$HOME/.gitconfig
ORIGINAL_TMUXCONF=$HOME/.tmux.conf
ORIGINAL_VIMRC=$HOME/.vimrc
ORIGINAL_XCOMPOSE=$HOME/.XCompose
ORIGINAL_XRESOURCES=$HOME/.Xresources
ORIGINAL_XINITRC=$HOME/.xinitrc
ORIGINAL_XSESSION=$HOME/.xsession

# Backup current dotfiles
mkdir -p $BACKUP_DIR
mv $ORIGINAL_BASHRC $ORIGINAL_BASH_PROFILE $ORIGINAL_PROFILE \
    $ORIGINAL_GITCONFIG $ORIGINAL_TMUXCONF $ORIGINAL_VIMRC \
    $ORIGINAL_XCOMPOSE $ORIGINAL_XINITRC $ORIGINAL_XRESOURCES $BACKUP_DIR

# Create vim folders
mkdir -p ~/.vim
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

# Install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install nice color scheme
wget https://raw.github.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Bright.vim -O ~/.vim/colors/Tomorrow-Night-Bright.vim

ln -s $PWD/bash/bashrc $ORIGINAL_BASHRC
ln -s $PWD/bash/bash_profile $ORIGINAL_BASH_PROFILE
ln -s $PWD/bash/profile $ORIGINAL_PROFILE
ln -s $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -s $PWD/tmux/tmux.conf $ORIGINAL_TMUXCONF
ln -s $PWD/vim/vimrc $ORIGINAL_VIMRC
ln -s $PWD/x/XCompose $ORIGINAL_XCOMPOSE
ln -s $PWD/x/Xresources $ORIGINAL_XRESOURCES
ln -s $PWD/x/xinitrc $ORIGINAL_XINITRC
ln -s $PWD/x/xinitrc $ORIGINAL_XSESSION
