#!/bin/sh

if [ ! -d ~/bin ]; then
    echo bin does not exist
    mkdir ~/bin
    mkdir ~/tmp
fi
wget https://github.com/Dependencies/Carthage/releases/download/0.9.4/Carthage.pkg
sudo installer -pkg Carthage.pkg -target /

#if [[ "$OSTYPE" == "darwin"* ]]; then
#    brew install carthage
#else
#    sudo apt-get install carthage
#fi

exit 0
