# Class: tomcat
#
# Sample Usage:
#  include tomcat
class tomcat {
	
	$servername = 'localhost'
	$serveralias = 'www.localhost www2.localhost'
	$staticresources = [
		'images', 
		'uploads'
		]
	
	$packages = [
		'apache2-mpm-prefork', 
		'tomcat7', 
		'libapache2-mod-jk'
		]

	define appendLine($file, $line) {
		exec { "/bin/echo '${line}' >> '${file}'":
			unless => "/bin/grep -Fx '${line}' '${file}'",
		}
	}

	
	package { $packages: 
		ensure => installed
	}

        file { '/etc/apache2/sites-enabled/tomcat':
                owner => root, group => root, mode => 0644,
                content => template("tomcat/tomcat.apache.conf.erb"),
		require => Package['apache2-mpm-prefork'],
		notify  => Service["apache2"],
        }

        file { '/etc/apache2/sites-enabled/000-default':
               	ensure => absent,  
		require => Package['apache2-mpm-prefork'],
        }

        file { '/etc/tomcat7/server.xml':
                owner => root, group => root, mode => 0644,
		notify => Service['tomcat7'],
                source => "puppet:///modules/tomcat/server.xml",
		require => Package['tomcat7'],
        }

	service {
		'apache2':
		ensure => running,
		enable => true,
		require => Package['apache2-mpm-prefork'],
	}

	service {
		'tomcat7': 
		ensure => running, 
		enable => true, 
		require => Package['tomcat7'], 
	}

	appendLine {
		'javahome': 
		file => '/etc/default/tomcat7', 
		line => 'JAVA_HOME=/usr/lib/jvm/java-7-oracle', 
	}


}
