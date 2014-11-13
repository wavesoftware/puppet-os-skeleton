# Runs an agent on every 30 minutes
#  default in NOOP mode
#  run explicitly by `puppet agent -t` or mcollective to enforce
class common::puppet::agent (
	$noop = true,
) {
	service { 'puppet':
		ensure => 'stopped',
		enable => false,
	}

	$rand = fqdn_rand(30, 'puppet agent -t')
	$noop_str = $noop ? {
		true    => '--noop',
		default => '',
	}

	cron { 'puppet agent':
		command => "/usr/bin/puppet agent -t ${noop_str}",
		user    => 'root',
		minute  => [$rand, $rand+30],
	}
}