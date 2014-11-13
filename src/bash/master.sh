#!/bin/bash

# Scripts for basic deployment on puppet master - prepare puppet master to serve content, sync repos!

set -e

export FACTER_repopath="$1"
export environment="$2"
export FACTER_puppetmaster="$3"

if ! dpkg -l | grep -q 'ii  puppetmaster'; then
	# Install puppet master - open source version
	source ${FACTER_repopath}/src/bash/internal/repo.sh
	apt-get install -y puppetmaster puppet
fi

# Fix for puppet agent lock, deprecated templatedir and setting puppet master address
source ${FACTER_repopath}/src/bash/internal/fix-puppet.sh

# Provision master with setup provision, sync repos and modules
puppet apply ${FACTER_repopath}/src/puppet/master-provision.pp --detailed-exitcodes  || [ $? -eq 2 ]
