#!/bin/bash

VERSION=$1

if [ $(grep -c Ubuntu /etc/product) -ge 1 ]; then
  curl -s -L https://chef.io/chef/install.sh | bash -s -- -v $VERSION
fi

if [ $(grep -c smartos /etc/product) -ge 1 ]; then
  pkgin -y install ruby215-chef build-essential
  gem install chef --version "$VERSION" --no-ri --no-rdoc
fi
