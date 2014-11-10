#!/bin/bash

codename=`lsb_release -c | awk '{print $2}'`
deb="puppetlabs-release-${codename}"
debfile="${deb}.deb"
srcdir='/usr/src'
debpath="${srcdir}/${debfile}"

if [ ! -f $debpath ]; then
	wget https://apt.puppetlabs.com/${debfile} -O ${debpath}
fi
if ! dpkg -l | grep -q 'ii  puppetlabs-release'; then
	dpkg -i $debpath && apt-get update
fi