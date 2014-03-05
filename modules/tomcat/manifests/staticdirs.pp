# Class: staticdirs
#
# create static folders in /opt/static
#
# Sample Usage: 
# $staticresources = [
#      'images',
#      'uploads'
# ]
# class { staticdirs:
#      staticresources => $staticresources, 
#      require => User['app'], 
# }
# 
class staticdirs($staticresources) {

        file { "/opt/static":
                owner => root,
                group => root,
                mode => 0755,
                ensure => directory,
        }

        define createStaticDirectory {
                $directory = $name
                file { "/opt/static/$directory":
                        owner => root,
                        group => root,
                        mode => 0755,
                        ensure => directory,
                }
                file { "/opt/static/$directory/htdocs":
                        owner => app,
                        group => app,
                        mode => 0775,
                        ensure => directory,
                }
        }

        createStaticDirectory { $staticresources: ; }

}
