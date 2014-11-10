class common::prompt {
	vcsrepo { "/var/lib/scmprompt":
		ensure   => 'present',
		provider => 'git',
		source   => "https://github.com/wavesoftware/scmprompt.git",
	}

	file { '/etc/profile.d/scmprompt.sh':
		ensure  => 'file',
		content => 'source /var/lib/scmprompt/scmprompt.sh',
	}
}