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

# Rackspace Cloud Monitoring - Not needed for development vm
  if (!$vagrant){
    yumrepo { "rackspace":
      baseurl => "http://stable.packages.cloudmonitoring.rackspace.com/centos-6-x86_64",
      enabled => 1,
      descr => "Rackspace Monitoring",
      gpgcheck => 0,
    }
  }


# Squishy custom repos
    yumrepo { "sqm":
      baseurl => "http://support.squishyclients.net/CentOS/6/updates/x86_64/",
      enabled => 1,
      descr => "Squishymedia CentOS-6 - Updates",
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
      require => Yumrepo["sqm"],
    }
  }

  # Vagrant takes care of users, ssh, and puppet configuration, so we
  # only set these things up if we're on a real server.
  if (!$vagrant) {
    class {'squishy_v1::users': }
    if $operatingsystem == 'centos' { class {'squishy_v1::ssh': } }

    # set puppet master
    augeas { "puppet.conf":
      context => "/files/etc/puppet/puppet.conf",
      changes => [
        "set agent/server puppet.squishyclients.net",
        "set main/environment $environment"
      ]
    }

    cron { "puppet":
      command => "/usr/bin/puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1",
      user => "root",
      hour => "*",
      minute => fqdn_rand( 60 ),
      ensure => present,
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

  if (!$vagrant){
      package {'rackspace-monitoring-agent':
        ensure => 'latest',
      }
  }

  package {'openssl':
    ensure => 'latest',
  }

  # New Relic
  #squishy_v1::newrelic_sysmon { 'newrelic': }

  if (!$vagrant) {
      class {'squishy_v1::newrelic_sysmon': }
  }
}
