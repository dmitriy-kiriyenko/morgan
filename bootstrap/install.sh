#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

wget https://github.com/iafonov/stack-rails/tarball/master
tar -zxf master
rm master
mv iafonov-stack-rails-* stack-rails

echo "** Everything was installed to $DIR/stack-rails"
echo "** Next step is to run bootstrap script from $DIR/stack-rails/bootstrap directory"