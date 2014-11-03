#!/usr/bin/env puppet

file { '/etc/hiera.yaml':
  ensure => 'file',
  source => '/vagrant/src/hiera/hiera.yaml',
}

file { '/var/lib/hiera':
  ensure   => 'directory',
  source   => '/vagrant/src/hiera/data',
  recurse  => true,
}

package { 'ruby': ensure => 'installed', }

package { 'librarian-puppet':
  ensure   => 'installed',
  provider => 'gem',
  require  => Package['ruby'],
}

file { '/etc/puppet/Puppetfile':
  source => '/vagrant/src/Puppetfile',
}

exec { 'librarian-puppet update --verbose':
  path      => $::path,
  require   => Package['librarian-puppet'],
  subscribe => File['/etc/puppet/Puppetfile'],
}
