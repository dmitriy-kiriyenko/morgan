#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Using default ruby"

sudo gem install bundler
sudo gem install soloist

cd $DIR && cd ../

rake cookbooks
echo "** Now you can edit soloistrc file and run soloist to converge the system"