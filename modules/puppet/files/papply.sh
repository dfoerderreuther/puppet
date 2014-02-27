#!/bin/sh
sudo puppet apply /puppet/manifests/site.pp \
	--modulepath=/puppet/modules/ \
	--verbose \
	 $*

