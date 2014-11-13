#!/bin/bash

# Scripts for basic deployment on agents - prepare puppet to be run

export FACTER_repopath="$1"
export environment="$2"
export FACTER_puppetmaster="$3"

set -e
set -x

if ! dpkg -l | grep 'ii  puppet ' | grep -q '3.7.'; then
	source ${FACTER_repopath}/src/bash/internal/repo.sh
	apt-get install -y puppet
fi

source ${FACTER_repopath}/src/bash/internal/fix-puppet.sh