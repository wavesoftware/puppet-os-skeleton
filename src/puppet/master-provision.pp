#!/usr/bin/env puppet

if ! $::repopath {
  fail('Set $::repopath facter value!')
}

package { 'git': 
  ensure => 'installed', 
}

package { 'r10k':
  ensure   => 'installed',
  provider => 'gem',
  require  => Package['git'],
}

Exec {
  path      => $::path,
  logoutput => true,
}

file { '/etc/r10k.yaml':
  ensure  => 'file',
  source  => "${::repopath}/src/r10k.yaml",
}

exec { 'repo-has-changed':
  command   => 'echo -n',
  logoutput => false,
  cwd       => $::repopath,
  onlyif    => '[ ! -f /var/spool/deployrepo.hash ] || test `git write-tree` != `cat /var/spool/deployrepo.hash`',
}

exec { 'r10k deploy':
  command     => 'r10k deploy environment -v && git write-tree > /var/spool/deployrepo.hash',
  cwd         => $::repopath,
  refreshonly => true,
  require     => [
    File['/etc/r10k.yaml'],
    Package['r10k'],
    Augeas['/etc/puppet/puppet.conf'],
    File['/etc/puppet/hiera.yaml'],
    File['/etc/hiera.yaml'],
  ],
  subscribe   => Exec['repo-has-changed'],
}

exec { 'puppetfile-has-changed':
  command   => 'echo -n',
  logoutput => false,
  cwd       => $::repopath,
  unless    => 'md5sum -c /var/spool/puppetfile.hash',
}

exec { 'r10k deploy with puppet modules':
  command     => 'r10k deploy environment -p -v && md5sum Puppetfile > /var/spool/puppetfile.hash',
  cwd         => $::repopath,
  refreshonly => true,
  require     => [
    File['/etc/r10k.yaml'],
    Package['r10k'],
    Augeas['/etc/puppet/puppet.conf'],
    File['/etc/puppet/hiera.yaml'],
    File['/etc/hiera.yaml'],
  ],
  subscribe   => Exec['puppetfile-has-changed'],
}

augeas { '/etc/puppet/puppet.conf':
  context => '/files/etc/puppet/puppet.conf',
  changes => [
    'set main/environmentpath $confdir/environments',
    'set main/show_diff true',
    "set agent/server ${::fqdn}",
    'set agent/classfile $vardir/classes.txt',
    'set agent/localconfig $vardir/localconfig',
    'rm main/templatedir',
  ],
}

file { '/var/lib/puppet/state/agent_disabled.lock':
  ensure => 'absent',
  notify => Service['puppetmaster'],
}

service { 'puppetmaster':
  ensure     => 'running',
  enable     => true,
  hasstatus  => true,
  hasrestart => true,
  subscribe  => Augeas['/etc/puppet/puppet.conf'],
}

file { '/etc/puppet/hiera.yaml':
  ensure => 'file',
  source => "${::repopath}/src/hiera.yaml",
}

file { '/etc/hiera.yaml':
  ensure => 'link',
  target => '/etc/puppet/hiera.yaml',
}

