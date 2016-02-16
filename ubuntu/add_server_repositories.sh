#!/bin/bash

# Add appt-add-repository
sudo apt-get install software-properties-common python-software-properties

echo 'Setting up fish'
sudo apt-add-repository -y ppa:fish-shell/release-2

echo 'Tmux repo'
sudo add-apt-repository -y ppa:pi-rho/dev
