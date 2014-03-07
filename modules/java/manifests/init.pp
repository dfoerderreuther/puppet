# Class: java
#
# Sample Usage:
#  include java
class java {

	$url="http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
	$tarball="jdk-7u51-linux-x64.tar.gz"
	$folder="jdk1.7.0_51"

	file { '/opt/install_java.sh':
                owner => root,
                group => root,
                mode => 0744,
                content => template("java/install_java.sh.erb"),
        }

	exec { "install_java":
		command => "/opt/install_java.sh",
		require => File['/opt/install_java.sh'], 
	}

}
