#!/bin/bash

export FACTER_repopath="$1"

set -e
set -x

source ${FACTER_repopath}/src/bash/repo.sh

if ! dpkg -l | grep -q 'ii  puppet '; then
	apt-get install -y puppet
fi

source ${FACTER_repopath}/src/bash/fix-puppet.sh