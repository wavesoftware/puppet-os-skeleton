#!/bin/bash

export FACTER_repopath="$1"

set -e
set -x

if ! dpkg -l | grep 'ii  puppet ' | grep -q '3.7.'; then
	source ${FACTER_repopath}/src/bash/repo.sh
	apt-get install -y puppet
	source ${FACTER_repopath}/src/bash/fix-puppet.sh
fi