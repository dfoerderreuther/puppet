class mysite {
	include apache

	file { '/etc/apache2/sites-enabled/mysite': 
		owner => root, group => root, mode => 0644, 
		source => 
			"puppet:///modules/admin/mysite/mysite.apache.conf", 
	}
}
