#!/bin/bash

while getopts v: opt
do
  case "$opt" in
    v)  version="$OPTARG";;
  esac
done

if [ $(grep -c "Ubuntu" /etc/product) -ge 1 ]; then
  apt-get update
  apt-get install -y wget ca-certificates
  curl -s -L https://chef.io/chef/install.sh | bash -s -- -v $version
fi

if [ $(grep -c "Joyent Instance" /etc/product) -ge 1 ]; then
  chef_package=$(pkgin search chef | grep "chef-[0-9]" | head -n1 | cut -d" " -f1)
  pkgin -y install $chef_package build-essential
  gem install chef --version "$version" --no-ri --no-rdoc
  mkdir -p /opt/chef/bin
  mkdir -p /opt/chef/embedded/bin
  ln -fs /opt/local/bin/chef-client /opt/chef/bin/chef-client
  ln -fs /opt/local/bin/ruby /opt/chef/embedded/bin/ruby
  ln -fs /opt/local/bin/gem /opt/chef/embedded/bin/gem
fi
