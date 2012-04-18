## Class: ssh
#
# This class installs openssh.
#
# Parameters:
#    -   $permitRootLogin = ('without-password'|'no'|'yes')
#
# Actions:  
#	Ensures that the openssh package is installed and distributes a config file.  ``/etc/ssh/sshd_config``                            
#
# Requires:  
#	Package["openssh"]  
#
class ssh($permitRootLogin='no', $port='22' ) {

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
    name	=> 'ssh',
    ensure	=> running,
    enable	=> true,
    hasstatus	=> true,
    hasrestart	=> true,
    require	=> File['/etc/ssh/sshd_config'],
  }
}
