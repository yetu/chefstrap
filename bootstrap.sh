#!/bin/bash

VERSION=$1

if [ grep Ubuntu /etc/product ]; then
  curl -s -L https://chef.io/chef/install.sh | bash -s -- -v $VERSION
fi

if [ grep smartos /etc/product ]; then
  pkgin -y install ruby215-chef build-essential
  gem install chef --version "$VERSION" --no-ri --no-rdoc
fi
