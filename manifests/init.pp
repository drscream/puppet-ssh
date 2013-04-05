class ssh( $permitRootLogin='no', $port='10110', $passwordAuthentication='no')
{
	package {'openssh-server':
		ensure => present
	}

	file {'/etc/ssh/sshd_config':
		content => template('ssh/sshd_config.erb'),
		mode    => '0400',
		notify  => Service['sshd'],
		require => Package['openssh-server'],
	}

	service {'sshd':
		name       => 'ssh',
		ensure     => running,
		enable     => true,
		hasstatus  => true,
		hasrestart => true,
		require	   => File['/etc/ssh/sshd_config'],
	}
}
