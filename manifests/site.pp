import 'classes/*.pp'
/*
TODO: Move
*/
class toolbox {
        file {'/usr/local/sbin/puppetsimple.sh':
	        owner => root, group => root, mode => 0755, 
        	content => "#!/bin/sh\npuppet agent --no-daemonize --onetime --verbose $1\n", 
        }
}


define appendLine($file, $line) {
	exec { "/bin/echo '${line}' >> '${file}'":
		unless => "/bin/grep -Fx '${line}' '${file}'",
	}
}	

class java7withhome {
	include java7
	appendLine {
		'java-home':
		file => '/etc/environment',  
		line => 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle', 	
	}
}
 
node 'puppetagent' {
        include toolbox
	include mysite
}
node 'cookbook' {
	include puppet
	include java7withhome
	include mysite
}
