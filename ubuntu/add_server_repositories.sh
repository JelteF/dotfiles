#!/bin/bash

set -eux

# Add appt-add-repository
sudo apt-get install -y software-properties-common

echo 'Neovim repo'
sudo add-apt-repository -y ppa:neovim-ppa/unstable

echo 'Fish repo'
sudo apt-add-repository -y ppa:fish-shell/release-3

echo 'Add nodejs'
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
