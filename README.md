# Puppet Open Source Skeleton using Vagrant and r10k

## Features:

 * A complete working solution with:
    * Puppet master and agent nodes on Puppet Open Source 3.7.x
    * Spotify Puppet Explorer nad PuppetDB
    * Hiera configuration
    * Dynamic GIT environments by r10k
    * Exernal puppet modules instalation and maintanance by r10k
    * Landrush local DNS
 * Coupe of bootstrap puppet classes:
    * `common::filebucket` - use of filebucket on all files
    * `common::packages` - cenral packages installation from hiera
    * `common::prompt` - a Bash command prompt with support for Git and Mercurial

## Usage:

```bash
# Install vagrant landrush
vagrant plugin install landrush

# Run 
vagrant up
```
Tip: After successful provision of master node, you can navigate to: https://master.vagrant.dev to see Puppet Explorer

## Contributing

Contributions are welcome!

To contribute, follow the standard [git flow](http://danielkummer.github.io/git-flow-cheatsheet/) of:

1. Fork it
1. Create your feature branch (`git checkout -b feature/my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin feature/my-new-feature`)
1. Create new Pull Request

Even if you can't contribute code, if you have an idea for an improvement please open an [issue](https://github.com/wavesoftware/puppet-os-skeleton/issues).