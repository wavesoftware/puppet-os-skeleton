#!/bin/bash

export FACTER_repopath="$1"
export environment="$2"

set -e
set -x

${FACTER_repopath}/src/bash/repo.sh

function puppetrun() {
	puppet apply ${FACTER_repopath}/${1} --environment $environment --detailed-exitcodes || if test $? != 2; then return $?; fi	
	return $?
}

if ! dpkg -l | grep -q 'ii  puppetmaster'; then
	apt-get install -y puppetmaster ruby
fi
puppetrun site/profile/manifests/master/provision.pp