#!/bin/bash

BACKUP_DIR=$PWD/backup
ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_BASH_PROFILE=$HOME/.bash_profile
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
ln -s $PWD/bash/bash_profile $ORIGINAL_BASH_PROFILE
ln -s $PWD/bash/profile $ORIGINAL_PROFILE
ln -s $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -s $PWD/tmux/tmux.conf $ORIGINAL_TMUXCONF
ln -s $PWD/vim/vimrc $ORIGINAL_VIMRC
ln -s $PWD/x/XCompose $ORIGINAL_XCOMPOSE

# Install all stuff
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo \
    apt-key add -
sudo "deb http://dl.google.com/linux/chrome/deb/ stable main" echo \
    /etc/apt/sources.list.d/google.list
sudo apt-get update
sudo --yes --force-yes apt-get install google-chrome-stable vim ack-grep \
    ruby-sass irssi htop ipython synapse xdotool mono-complete gnuplot

sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp/KeePassHttp.dll -O /usr/lib/keepass2/KeePassHttp.dll
sudo wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp/Newtonsoft.Json.dll -O /usr/lib/keepass2/Newtonsoft.Json.dll

sudo apt-get upgrade

sudo apt-get install texlive-*
