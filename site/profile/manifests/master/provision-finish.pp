
class profile::master::provision-finish {
	
	$deb      = "puppetlabs-release-${::lsbdistcodename}"
	$debfile  = "${deb}.deb"
	$srcdir   = '/usr/src'
	$debpath  = "${srcdir}${deb}"

	Exec {
		path => $::path,
	}

	exec { "curl https://apt.puppetlabs.com/${deb} -o ${debpath}":
		cwd     => $srcdir,
		creates => $debpath,
		before  => Class['puppetdb'],
	}

	exec { "dpkg -iv $debpath && apt-get update":
		alias   => 'install-and-update-os',
		unless  => 'dpkg -l | grep -q \'ii  time\'',
		require => Exec["curl https://apt.puppetlabs.com/${deb} -o ${debpath}"],
		before  => Class['puppetdb'],
	}
}

include profile::master::provision-finish
include puppetdb 
include puppetdb::master::config
