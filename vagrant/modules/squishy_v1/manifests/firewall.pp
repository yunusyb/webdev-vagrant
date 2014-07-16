class squishy_v1::firewall {
	service { iptables:
		ensure => running,
		hasstatus => true,
	}
	$ipv4_file = $operatingsystem ? {
		"debian"          => '/etc/iptables/rules.v4',
		/(RedHat|CentOS)/ => '/etc/sysconfig/iptables',
	}
	#exec { "purge default firewall":
	#	command => "/sbin/iptables -F && /sbin/iptables-save > $ipv4_file && /sbin/service iptables restart",
	#    onlyif  => "/usr/bin/test `/bin/grep \"Firewall configuration written by\" $ipv4_file | /usr/bin/wc -l` -gt 0",
	#    user    => 'root',
	#}
	/* Make the firewall persistent */
	#exec { "persist-firewall":
	#	command     => "/bin/echo \"# This file is managed by puppet. Do not modify manually.\" > $ipv4_file && /sbin/iptables-save >> $ipv4_file",
	#refreshonly => true,
	#	user        => 'root',
	#}

	#Firewall {
	#	notify  => Exec["persist-firewall"],
	#}

	firewall {'001 custom SSH port':
		port   => '22421',
		proto  => 'tcp',
		action => 'accept',
	}
	firewall {'002 monitor':
		source => '166.78.2.161',
		proto  => 'all',
		action => 'accept',
	}
	firewall {'003 Squishy office IP':
		source => '50.196.24.121',
		action => 'accept',
		proto  => 'all',
	}
}
