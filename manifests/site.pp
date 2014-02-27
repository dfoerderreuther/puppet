import 'classes/*.pp'
/*
TODO: MOVE
*/
class toolbox {
        file {'/usr/local/sbin/puppetsimple.sh':
	        owner => root, group => root, mode => 0755, 
        	content => "#!/bin/sh\npuppet agent --no-daemonize --onetime --verbose $1\n", 
        }
}
 
node 'puppetagent' {
        include toolbox
	include mysite
}
node 'cookbook' {
	include puppet
	include mysite
}
