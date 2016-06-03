#!/usr/bin/env bash
export APP_NAME="IntegrateMe"
export APP_ROOT="/vagrant"

export DEBIAN_FRONTEND="noninteractive"
apt-get update

# Add 3rd-party repos
apt-get install -y software-properties-common
# Ruby
apt-add-repository -y ppa:brightbox/ruby-ng
# nodejs
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo 'deb https://deb.nodesource.com/node_6.x trusty main' >> /etc/apt/sources.list

apt-get update

# Install dev-tools
apt-get install -y vim tmux jq git

# Install dependencies
apt-get install -y build-essential zlib1g-dev libpq-dev libsqlite3-dev
apt-get install -y ruby2.1 ruby2.1-dev ruby-switch
apt-get install -y nodejs

# Switch default ruby
ruby-switch --set ruby2.1

# Install bundler
gem install bundler
