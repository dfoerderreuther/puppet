# Class: tomcat7
#
# install apache with config
#
# Sample Usage: 
# class { tomcat7:
# }
# 
class tomcat7 {

        file { '/etc/tomcat7/server.xml':
                owner => root,
                group => root,
                mode => 0644,
                notify => Service['tomcat7'],
                source => "puppet:///modules/tomcat/server.xml",
                require => Package['tomcat7'],
        }

        service {
                'tomcat7':
                ensure => running,
                enable => true,
                require => [ 
			Package['tomcat7'],
			Exec['install_java'], 
			], 
        }

}
