node 'myhost' {
	include puppet
	include java7, java7home
	include tomcat
}
