# Sets current environment as currently active
class common::environment {
	augeas { 'puppet.conf-set-environment':
		context => '/files/etc/puppet/puppet.conf',
		changes => [
			"set agent/environment ${environment}",
		],
	}
}