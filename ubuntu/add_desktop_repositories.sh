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
