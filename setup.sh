#!/bin/bash

set -ux

ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_BASH_PROFILE=$HOME/.bash_profile
ORIGINAL_PROFILE=$HOME/.profile
ORIGINAL_INPUTRC=$HOME/.inputrc
ORIGINAL_GITCONFIG=$HOME/.gitconfig
ORIGINAL_TIGRC=$HOME/.tigrc
ORIGINAL_GDBINIT=$HOME/.gdbinit
ORIGINAL_TMUXCONF=$HOME/.tmux.conf
ORIGINAL_VIMRC=$HOME/.vimrc
ORIGINAL_XCOMPOSE=$HOME/.XCompose
ORIGINAL_XRESOURCES=$HOME/.Xresources
ORIGINAL_XINITRC=$HOME/.xinitrc
ORIGINAL_XPROFILE=$HOME/.xprofile
ORIGINAL_XSESSION=$HOME/.xsession
ORIGINAL_SSHRC=$HOME/.sshrc

# Create vim folders
mkdir -p ~/.vim/{autoload,colors}
mkdir -p ~/.config
mkdir -p ~/.ptpython
mkdir -p ~/.config/fish/completions

# PATH dirs
mkdir -p ~/.gem/ruby/2.2.0/bin
mkdir -p ~/go/bin
mkdir -p ~/.local/bin
mkdir -p ~/.cargo/bin

ln -snf "$PWD/bash/bashrc" "$ORIGINAL_BASHRC"
ln -snf "$PWD/bash/bash_profile" "$ORIGINAL_BASH_PROFILE"
ln -snf "$PWD/bash/profile" "$ORIGINAL_PROFILE"
ln -snf "$PWD/bash/inputrc" "$ORIGINAL_INPUTRC"
ln -snf "$PWD/git/gitconfig" "$ORIGINAL_GITCONFIG"
ln -snf "$PWD/git/tigrc" "$ORIGINAL_TIGRC"
ln -snf "$PWD/gdb/gdbinit" "$ORIGINAL_GDBINIT"
ln -snf "$PWD/postgres/psqlrc" "$HOME/.psqlrc"
ln -snf "$PWD/tmux/tmux.conf" "$ORIGINAL_TMUXCONF"
ln -snf "$PWD/vim/vimrc" "$ORIGINAL_VIMRC"
ln -snf "$PWD/vim/vimrc" "$HOME/.vim/init.vim"
ln -snf "$PWD/vim/fzf_ignore" "$HOME/.vim/fzf_ignore"
ln -snf "$PWD/fish/"* "$HOME/.config/fish/"
ln -snf "$PWD/x/XCompose" "$ORIGINAL_XCOMPOSE"
ln -snf "$PWD/x/Xresources" "$ORIGINAL_XRESOURCES"
ln -snf "$PWD/x/xinitrc" "$ORIGINAL_XINITRC"
ln -snf "$PWD/x/xsession" "$ORIGINAL_XSESSION"
ln -snf "$PWD/x/xprofile" "$ORIGINAL_XPROFILE"
ln -snf "$PWD/ssh/sshrc" "$ORIGINAL_SSHRC"

ln -snf "$PWD/ptpython/"* ~/.ptpython/

# Remove ~/.config directories that should be symlinked
for dir in "$PWD/config_dir/"*; do
    rm -rf "$HOME/.config/${dir#$PWD/config_dir/}";
done
ln -sf "$PWD/config_dir/"* ~/.config/

mkdir -p "$HOME/.ssh"
chmod 0700 "$HOME/.ssh"

# Install fisherman
if command -v fish; then
  fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher && fisher update'
fi

if command -v nvim; then
    nvim +PlugInstall +qall
else
    vim +PlugInstall +qall
fi
