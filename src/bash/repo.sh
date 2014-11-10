#!/bin/bash

codename=`lsb_release -c | awk '{print $2}'`
deb="puppetlabs-release-${codename}"
debfile="${deb}.deb"
srcdir='/usr/src'
debpath="${srcdir}/${debfile}"

set -e
set -x

if [ ! -f $debpath ]; then
	curl https://apt.puppetlabs.com/${debfile} -o ${debpath}
fi
if ! dpkg -l | grep -q 'ii  puppetlabs-release'; then
	dpkg -i $debpath && apt-get update
fi