#!/bin/bash

puppet apply ${FACTER_repopath}/src/puppet/fix-agents.pp --detailed-exitcodes  || [ $? -eq 2 ]