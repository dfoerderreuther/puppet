puppet
======

Puppet


	cd /etc
	mv puppet puppet.origin
	git clone git@github.com:dfoerderreuther/puppet.git
	ln -s /etc/puppet /puppet
	sudo puppet apply /puppet/manifests/site.pp \
		--modulepath=/puppet/modules/ \
		--verbose

