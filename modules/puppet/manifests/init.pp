class puppet {
	file { '/usr/local/bin/papply': 
		source => 'puppet:///modules/puppet/papply.sh', 
		mode => '0755', 
	}
	
	file { '/usr/local/bin/pull-updates': 
		source => 'puppet:///modules/puppet/pull-updates.sh', 
		mode => '0755', 
	}
	
	cron { 'run-puppet': 
		user => 'vagrant', 
		command => '/usr/local/bin/pull-updates >> /var/log/puppet-pull-updates.log ', 
		minute => '*/1', 
		hour => '*', 
	}
}
