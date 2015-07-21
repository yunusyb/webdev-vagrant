class squishy_v1::minimum {
  Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

  class {'squishy_v1::shell_prompt': }
  class {'::ntp' : }
  if $operatingsystem == 'centos' {
    class {'squishy_v1::selinux': }
    class {'squishy_v1::yum-cron': }
    class {'epel': }
    # IUS repo
    yumrepo { "IUS":
    #  baseurl => "http://dl.iuscommunity.org/pub/ius/stable/$operatingsystem/$operatingsystemmajrelease/$architecture",
    baseurl => "http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64",
      descr => "IUS Community repository",
      enabled => 1,
      gpgcheck => 0,
    }
    # RPMForge (needed for php-fpm among others)
    yumrepo { "RPMForge":
      baseurl => "http://apt.sw.be/redhat/el6/en/$architecture/rpmforge",
      mirrorlist => "http://mirrorlist.repoforge.org/el6/mirrors-rpmforge",
      descr => "RPMForge",
      enabled => 1,
      gpgcheck => 0,
    }

    # Centos 6.4 doesn't include this lens by default.
    # We got it from https://github.com/estahn/augeas/blob/master/lenses/ssh.aug
    file { "/usr/share/augeas/lenses/ssh.aug":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/squishy_v1/ssh.aug"
    }
    package { 'puppetlabs-release':
      provider => 'rpm',
      source => 'http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm',
    }
    package {'yum-plugin-replace':
        ensure => 'latest',
        require => Yumrepo["IUS"],
     }
    # Ensure puppet is installed and at latest version
    package { 'puppet':
      #ensure => '3.4.3',
      ensure => 'installed',
      require => Package['puppetlabs-release'],
    }

    package { 'deep_merge':
      provider => 'gem',
    }

    package {'git':
      ensure => 'latest',
    }
  }

  package {'bash-completion':
    ensure  =>  'latest',
  }

  package {'htop':
    ensure => 'latest',
  }

  # fail2ban
  package {'fail2ban':
    ensure => 'latest',
  }
  service {'fail2ban':
    ensure => 'running',
    enable => true,
  }

  package {'openssl':
    ensure => 'latest',
  }

}
