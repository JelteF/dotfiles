#!/bin/bash

ubuntu/add_server_repositories.sh

# Update sources
sudo apt-get update

# Install everything
ubuntu/install_server_utils.sh

sudo apt-get upgrade
