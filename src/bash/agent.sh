#!/bin/bash

export FACTER_repopath="$1"

set -e
set -x

bash ${FACTER_repopath}/src/bash/repo.sh

apt-get install -y puppet