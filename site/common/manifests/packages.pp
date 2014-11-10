class common::packages {
	package { ['htop', 'sysstat', 'tcpdump', 'iotop']:
		ensure => 'installed',
	}
}