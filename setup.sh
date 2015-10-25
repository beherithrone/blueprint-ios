#!/bin/sh

if [ ! -d ~/bin ]; then
    echo bin does not exist
    mkdir ~/bin
    mkdir ~/tmp
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install carthage
else
    sudo apt-get install carthage
fi

exit 0
