#!/bin/bash

set -e
set -x

apt-get install -y puppetmaster ruby
puppet apply /vagrant/site/profile/manifests/master/provision-base.pp
puppet apply /vagrant/site/profile/manifests/master/provision-finish.pp
