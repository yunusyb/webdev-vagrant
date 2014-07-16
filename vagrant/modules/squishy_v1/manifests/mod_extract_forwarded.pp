class squishy_v1::mod_extract_forwarded {
  apache::mod { 'proxy': }

  $mef_accept = hiera('squishy_v1::mod_extract_forwarded::mef_accept', 'all')

  if $operatingsystem == 'centos' {
    package {'mod_extract_forwarded':
      ensure => latest;
    }
  }
  # MEF config
  file { '/etc/httpd/conf.d/99_extract_forwarded.conf':
         content => template('squishy_v1/extract_forwarded.conf.erb'),
         group => 'root',
         owner => 'root',
         mode => 'ug+w,o-w',
  }

  # Remove redundant .load file
  file { '/etc/httpd/conf.d/extract_forwarded.load':
      ensure => absent,
  }

}
