# Common stages configuration
class common::stages {
	stage { 'before': }
	stage { 'after': }

	Stage['before'] -> Stage['main'] ~> Stage['after']
} 