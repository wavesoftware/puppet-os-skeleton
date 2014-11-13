#!/bin/bash

# Fixes to agents - to be run

puppet apply ${FACTER_repopath}/src/puppet/fix-agents.pp --detailed-exitcodes  || [ $? -eq 2 ]