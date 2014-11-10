#!/bin/bash

export FACTER_repopath="$1"
export environment="$2"

set -e
set -x

bash ${FACTER_repopath}/src/bash/repo.sh

if ! dpkg -l | grep -q 'ii  puppetmaster'; then
	apt-get install -y puppetmaster ruby
fi

puppet apply ${FACTER_repopath}/site/profile/manifests/master/provision.pp --detailed-exitcodes  || [ $? -eq 2 ]
