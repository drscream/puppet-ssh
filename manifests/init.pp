## Class: ssh
#
# This class installs openssh.
#
# ** Only tested on CentOS/RHEL5.  **
#
# Parameters:
#    -   $permitrootlogin = 
#                            'without-password'
#                            'no'
#                            'yes'
#
# Actions:  
#	Ensures that the openssh package is installed and distributes a config file.  ``/etc/ssh/sshd_config``                            
#
# Requires:  
#	Package["openssh"]  
#
# ``assumes package was installed via kickstart``
class ssh {
  $permitrootlogin = 'without-password'

  file { "/etc/ssh/sshd_config" :
    notify  => Service['sshd'],
    content => template("ssh/sshd_config.erb"),
    mode    => 400
  }

  service { "sshd" :
    ensure => running,
    enable => true
  }
  package { "openssh-server" : ensure => present }
}
