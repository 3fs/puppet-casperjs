puppet-casperjs
===============

Simple puppet module that installs CasperJS - navigation scripting and testing utility for PhantomJS.

Using
-----

	class { 'casperjs': 
		package_version => '1.0.3',
		package_update => true,
		install_dir => '/usr/local/bin',
		source_dir => '/opt',
	}
=======
Simple puppet module that installs CasperJS
