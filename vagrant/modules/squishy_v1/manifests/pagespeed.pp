class squishy_v1::pagespeed {
  file { "/etc/httpd/conf.d/pagespeed.conf":
    ensure => file,
    mode   => 0644,
    owner  => 'root',
    group  => 'root',
  }
}
