#!/bin/bash

# Add appt-add-repository
sudo apt-get install software-properties-common python-software-properties

echo 'Neovim repo'
sudo add-apt-repository -y ppa:neovim-ppa/unstable

echo 'Fish repo'
sudo apt-add-repository -y ppa:fish-shell/release-2

echo 'Tmux repo'
sudo add-apt-repository -y ppa:pi-rho/dev
