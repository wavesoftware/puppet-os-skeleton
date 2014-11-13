Puppet Open Source Skeleton using Vagrant and r10k
==================================================

Features:
---------

 * A complete working solution with:
    * Puppet master and agent nodes on Puppet Open Source 3.7.*
    * Spotify Puppet Explorer nad PuppetDB
    * Hiera configuration
    * Dynamic GIT environments by r10k
    * Exernal puppet modules instalation and maintanance by r10k
    * Landrush local DNS
 * Coupe of bootstrap puppet classes:
    * `common::filebucket` - use of filebucket on all files
    * `common::packages` - cenral packages installation from hiera
    * `common::prompt` - a Bash command prompt with support for Git and Mercurial

Usage:
------

```bash
# Install vagrant landrush
vagrant plugin install landrush

# Checkout
git clone dddd
cd dddd

# Run 
vagrant up
```
Tip: After successful provision of master node, you can navigate to: https://master.vagrant.dev to see Puppet Explorer
