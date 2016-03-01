#!/bin/bash
# Sign Google certificate
echo 'Setting up Google Chrome stuff'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo \
    apt-key add -

# Add Google to sources
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee \
    /etc/apt/sources.list.d/google.list > /dev/null

# Add insync stuff
echo 'Setting up insync stuff'
wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key \
    | sudo apt-key add -

echo "deb http://apt.insynchq.com/ubuntu vivid non-free contrib" | sudo tee \
    /etc/apt/sources.list.d/insync.list > /dev/null

# Add synapse
echo 'Adding synapse repo'
sudo apt-add-repository -y ppa:synapse-core/testing

# Add Telegram repo
echo 'Adding telegram repo'
sudo add-apt-repository -y ppa:atareao/telegram

# Awesome
sudo add-apt-repository -y ppa:klaus-vormweg/awesome

# Keepass and plugins
sudo add-apt-repository -y ppa:jtaylor/keepass
sudo add-apt-repository -y ppa:dlech/keepass2-plugins
