# Class: apache
#
# install apache with config
#
# Sample Usage: 
# $staticresources = [
#      'images',
#      'uploads'
# ]
# class { apache:
#      staticresources => $staticresources, 
#      require => User['app'], 
# }
# 
class apache($staticresources) {

        service {
                'apache2':
                ensure => running,
                enable => true,
                require => Package['apache2-mpm-prefork'],
        }

        file { '/etc/apache2/sites-enabled/000-default':
                ensure => absent,
                require => Package['apache2-mpm-prefork'],
        }

        file { '/etc/apache2/sites-enabled/tomcat':
                owner => root,
                group => root,
                mode => 0644,
                content => template("tomcat/tomcat.apache.conf.erb"),
                require => Package['apache2-mpm-prefork'],
                notify  => Service["apache2"],
        }

}
