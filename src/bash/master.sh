#!/bin/bash

set -e
set -x

apt-get install -y puppetmaster
puppet apply /vagrant/src/puppet/puppetmaster-setup.pp