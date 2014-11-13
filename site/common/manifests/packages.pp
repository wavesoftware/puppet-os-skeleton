# Install common packages
class common::packages {

	$packages = hiera_array('packages')

	package { $packages:
		ensure => 'installed',
	}
}