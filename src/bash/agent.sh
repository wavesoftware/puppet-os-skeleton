#!/bin/bash

# Scripts for basic deployment on agents - prepare puppet to be run

set -e

export FACTER_repopath="$1"
export environment="$2"
export FACTER_puppetmaster="$3"

# Fix for Ubuntu TTY bug: https://github.com/mitchellh/vagrant/issues/1673
source ${FACTER_repopath}/src/bash/internal/fix-ubuntu-tty.sh

if ! dpkg -l | grep 'ii  puppet ' | grep -q '3.7.'; then
	# Install puppet agent - open source version
	source ${FACTER_repopath}/src/bash/internal/repo.sh
	apt-get install -y puppet
fi

# Fix for puppet agent lock, deprecated templatedir and setting puppet master address
source ${FACTER_repopath}/src/bash/internal/fix-puppet.sh