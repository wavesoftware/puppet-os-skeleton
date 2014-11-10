#!/bin/bash

set -e
set -x

apt-get install -y puppetmaster ruby
export FACTER_repopath="$1"
environment="$2"
puppet apply ${FACTER_repopath}/site/profile/manifests/master/provision-base.pp --environment $environment
puppet apply ${FACTER_repopath}/site/profile/manifests/master/provision-finish.pp --environment $environment
