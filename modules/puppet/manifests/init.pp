class puppet {
	file { '/usr/local/bin/papply': 
		source => 'puppet:///modules/puppet/papply.sh', 
		mode => '0755', 
	}
	
	file { '/usr/local/bin/pull-updates': 
		source => 'puppet:///modules/puppet/pull-updates.sh', 
		mode => '0755', 
	}
}

class puppet::cron {
	inclode puppet
	
	
	file { '/var/log/puppet-pull-updates.log': 
		ensure => 'present', 
		mode => '0666', 
	}
	
	cron { 'run-puppet': 
		ensure => 'present', 
		user => 'vagrant', 
		command => '/usr/local/bin/pull-updates >> /var/log/puppet-pull-updates.log ', 
		minute => '*/10', 
		hour => '*', 
	}
}
