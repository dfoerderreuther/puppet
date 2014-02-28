# Class: tomcat
#
# Sample Usage:
#  include tomcat
class tomcat {

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
                source =>
                        "puppet:///modules/tomcat/tomcat.apache.conf",
        }

	/*file { '/etc/apache2/workers.properties': 
		owner => root, group => root, mode => 0644, 
		source => "puppet:///modules/tomcat/workers.properties", 
	}

        file { '/etc/apache2/conf.d/mod_jk.conf':
                owner => root, group => root, mode => 0644,
                source => "puppet:///modules/tomcat/mod_jk.conf",
        }*/

        file { '/etc/tomcat7/server.xml':
                owner => root, group => root, mode => 0644,
		notify => Service['tomcat7'],
                source => "puppet:///modules/tomcat/server.xml",
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
