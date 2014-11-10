class common::filebucket {
	filebucket { 'puppet': 
		server => $::puppet_server,
	}
}