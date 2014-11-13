#!/bin/bash

# Basic script that add apt.puppetlabs.com repo to machine.

codename=`lsb_release -c | awk '{print $2}'`
deb="puppetlabs-release-${codename}"
debfile="${deb}.deb"
srcdir='/usr/src'
debpath="${srcdir}/${debfile}"

if ! dpkg -l | grep -q 'ii  curl'; then
	apt-get -y install curl
fi
if [ ! -f $debpath ]; then
	stdbuf -oL -eL curl https://apt.puppetlabs.com/${debfile} -o ${debpath} 2>&1
fi
if ! dpkg -l | grep -q 'ii  puppetlabs-release'; then
	dpkg -i $debpath && apt-get update
fi