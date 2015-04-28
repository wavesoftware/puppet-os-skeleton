# Install common packages
class common::packages {

	$packages = hiera_array('packages')

	ensure_packages( $packages )
}