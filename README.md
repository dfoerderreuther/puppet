puppet
======

Puppet


	git clone git@github.com:dfoerderreuther/puppet.git
	sudo mv puppet /puppet
	cd /etc
	sudo mv puppet puppet.origin
	sudo ln -s /puppet /etc/puppet
	sudo puppet apply /puppet/manifests/site.pp \
		--modulepath=/puppet/modules/ \
		--verbose

