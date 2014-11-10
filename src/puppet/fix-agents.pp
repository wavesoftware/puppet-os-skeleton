#!/usr/bin/env puppet

augeas { 'puppet.conf':
	context => '/files/etc/puppet/puppet.conf',
	changes => [
		'rm main/templatedir',
		"set agent/server ${::puppetmaster}",
	],
}

file { '/var/lib/puppet/state/agent_disabled.lock':
	ensure => 'absent',
}