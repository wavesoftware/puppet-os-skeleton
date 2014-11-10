class common::puppet::agent {
	service { 'puppet':
		ensure => 'stopped',
		enable => false,
	}

	$rand = fqdn_rand(30, 'puppet agent -t')

	cron { 'puppet agent':
		command => "/usr/bin/puppet agent -t --noop",
		user    => root,
		minute  => [$rand, $rand+30],
	}
}