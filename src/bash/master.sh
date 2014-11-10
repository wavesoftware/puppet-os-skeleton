#!/bin/bash

export FACTER_repopath="$1"
export environment="$2"
export FACTER_puppetmaster="$3"

set -e
set -x

if ! dpkg -l | grep -q 'ii  puppetmaster'; then
	source ${FACTER_repopath}/src/bash/repo.sh
	apt-get install -y puppetmaster ruby
fi

source ${FACTER_repopath}/src/bash/fix-puppet.sh
puppet apply ${FACTER_repopath}/src/puppet/master-provision.pp --detailed-exitcodes  || [ $? -eq 2 ]
