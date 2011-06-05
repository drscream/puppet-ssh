## Class: ssh
#
# This class installs openssh.
#
# Parameters:
#    -   $permitrootlogin = ('without-password'|'no'|'yes')
#
# Actions:  
#	Ensures that the openssh package is installed and distributes a config file.  ``/etc/ssh/sshd_config``                            
#
# Requires:  
#	Package["openssh"]  
#
class ssh($permitrootlogin='no') {

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
