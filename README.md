puppet
======

Puppet


	cd /etc
	mv puppet puppet.origin
	sudo puppet apply /puppet/manifests/site.pp \
		--modulepath=/puppet/modules/ \
		--verbose
	ln -s /etc/puppet /puppet

