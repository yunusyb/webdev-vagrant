class squishy_config::lamp {
  include 'squishy_config::mysql'
  include 'squishy_config::apache'

  include 'squishy_config::apc_ini'

  # add mysql bindings for PHP
  class { 'mysql::php': }
  class { 'apache::mod::php':
    require => Class['squishy_config::apache'],
  }

  # PHP ini
  augeas { '/etc/php.ini':
    notify  => Service['httpd'],
    context => "/files/etc/php.ini/PHP",
    changes => [
      'set memory_limit 256M',
      'set date.timezone PST8PDT',
      'set post_max_size 1024M',
      'set upload_max_filesize 1024M',
    ],
  }

  $php_packages = $osfamily ? {
    'RedHat' => [
      'php',
      'php-gd',
      'php-pdo',
      #'php-mysql', # this one is handled by "lamp.pp"
      'php-xml',
      'php-mbstring',
      'php-pecl-apc',
      'php-devel',
      'pcre-devel',
      'httpd-devel',
      'php-pecl-memcache',
      'memcached',
      'php-pear-DB',
    ],
    'Debian' => [
      'php5',
      'php5-gd',
      #'php5-mysql', # handled by "lamp.pp"
      'php5-memcache',
      'php-pear',
      'php-apc',
      'php-xml-parser',
      'memcached',
      'php-db',
      'libpcre3-dev',
      'php5-dev',
    ],
  }

  #package { $php_packages: ensure => 'installed' }
}
