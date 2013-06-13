/**

 * Basic system setup for running Drupal sites.
 *
 * Does not actually download Drupal; it's assumed you have this in git.
 */
class squishy_config::drupal {
  include squishy_config::lamp
  include pear

  Exec { path => "/usr/bin/" }

  pear::package { "PEAR": }

  pear::package { "drush":
    version => "5.9.0",
    repository => "pear.drush.org",
  }

  # uploadprogress (a three-part dance)
  pear::package { "uploadprogress":
    repository => "pecl.php.net",
    require => Pear::Package['PEAR']
  }

  file { '/etc/php.d/uploadprogress.ini':
    ensure => present,
    require => Pear::Package['uploadprogress'],
  }

  augeas { 'uploadprogress':
    context => "/files/etc/php.d/uploadprogress.ini/.anon",
    changes => [
      "set extension uploadprogress.so",
    ],
    require => File['/etc/php.d/uploadprogress.ini'],
  }

  # memcache (a three-part dance)
  augeas { 'memcache':
    context => "/files/etc/php.d/memcache.ini/.anon",
    changes => [
      "set extension memcache.so",
    ],
    require => File['/etc/php.d/memcache.ini'],
  }

  file { '/etc/php.d/memcache.ini':
    ensure => present,
    require => Package['php-pecl-memcache'],
  }
}
