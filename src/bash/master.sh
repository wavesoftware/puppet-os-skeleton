#!/bin/bash

set -e
set -x

apt-get install -y puppetmaster augeas-tools facter mcollective rsync
puppet apply /vagrant/src/puppet/puppetmaster-setup.pp