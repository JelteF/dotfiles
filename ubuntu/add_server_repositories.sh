#!/bin/bash
echo 'Setting up fish'
sudo apt-add-repository ppa:fish-shell/release-2

sudo apt-get install -y python-software-properties software-properties-common
echo 'Tmux repo'
sudo add-apt-repository -y ppa:pi-rho/dev
