class squishy_v1::yum-cron {
  file { "/etc/sysconfig/yum-cron":
    mode => 644,
    owner => root,
    group => root,
    source => "puppet:///modules/squishy_v1/yum-cron"
  }

  package { 'yum-cron':
    ensure => latest;
  }
}
