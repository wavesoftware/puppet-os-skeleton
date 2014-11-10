#!/bin/bash

export FACTER_repopath="$1"
export environment="$2"

set -e
set -x

if ! dpkg -l | grep -q 'ii  puppetmaster'; then
	source ${FACTER_repopath}/src/bash/repo.sh
	apt-get install -y puppetmaster ruby
	source ${FACTER_repopath}/src/bash/fix-puppet.sh
fi

puppet apply ${FACTER_repopath}/site/profile/manifests/master/provision.pp --detailed-exitcodes  || [ $? -eq 2 ]
