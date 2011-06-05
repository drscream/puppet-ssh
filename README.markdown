# ssh puppet module  
  
## Class: ssh  

This class installs openssh.  


### Parameters:  
	$permitrootlogin =  'without-password' | 'no'  |  'yes'  
	# defaults to no

### Actions:  

Ensures that the openssh package is installed and distributes a config file.  ``/etc/ssh/sshd_config``  

### Requires:  
	Package["openssh"]  

### Usage

    node default {
      class { 'ssh': }						# accept default param OR 
      class { 'ssh': permitrootlogin => 'without-password' }	# override paramater
    }
