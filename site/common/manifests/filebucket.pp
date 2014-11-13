# Use filebucket by default
class common::filebucket {
	filebucket { 'puppet': 
		server => $::puppet_server,
	}
}