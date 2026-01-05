#!/bin/bash

set -eux

# Add appt-add-repository
sudo apt-get install -y software-properties-common

echo 'Fish repo'
sudo apt-add-repository -y ppa:fish-shell/release-4

echo 'Add nodejs'
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
