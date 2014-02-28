# Class: java7home
#
# Sample Usage:
#  include java7home
class java7home {
	
	define appendLine($file, $line) {
		exec { "/bin/echo '${line}' >> '${file}'":
			unless => "/bin/grep -Fx '${line}' '${file}'",
		}
	}

	appendLine {
		'java-home':
		file => '/etc/environment',  
		line => 'JAVA_HOME=/usr/lib/jvm/java-7-oracle', 	
	}

	appendLine {
		'bash.bashrc': 
		file => '/etc/bash.bashrc', 
		line => 'JAVA_HOME=/usr/lib/jvm/java-7-oracle', 
	}
}
