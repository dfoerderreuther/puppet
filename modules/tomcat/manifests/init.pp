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

	group { 'app': 
		ensure => present, 
	}

	user { 'app':
		ensure     => present,
		gid        => 'app',
		shell      => '/bin/false',
		home       => '/home/app',
		managehome => true,
		require => Group['app'], 
	}

	user { 'tomcat7': 
		ensure => present, 
		groups => 'app', 
	}

	package { $packages: 
		ensure => installed
	}


	class { staticdirs:
		staticresources => $staticresources, 
		require => User['app'],
	}

	class { apache:
		staticresources => $staticresources, 
		require => User['app'],
	}

	class { tomcat7:
	}

	define appendLine($file, $line) {
		exec { "/bin/echo '${line}' >> '${file}'":
			unless => "/bin/grep -Fx '${line}' '${file}'",
		}
	}
	
        appendLine {
               'javahome':
               file => '/etc/default/tomcat7',
               line => 'JAVA_HOME=/usr/lib/jvm/java-7-oracle',
        }


}
