class squishy_v1::lamp {
  include 'squishy_v1::mysql'
  include 'squishy_v1::apache'
  include 'squishy_v1::apc'

  if (!$vagrant) {
      include 'squishy_v1::newrelic_php'
  }

  # add mysql bindings for PHP
  # TODO: abstract this out so that we can do both PHP and Python bindings on
  # the same box, for example.
  class { 'mysql::bindings':
    php_enable => true
  }
  class { 'apache::mod::php':
    require => Class['squishy_v1::apache'],
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
      'set magic_quotes_gpc Off',
      'set max_execution_time 240',
      'set memcache.hash_strategy consistent',
    ],
  }

  # Uncomment these lines if you want some pear packages.
  # See https://github.com/rafaelfelix/puppet-pear for usage.
  #include pear
  #pear::package { "PEAR": }

  #
  # Last but not least, we require a few other misc packages. Many packages are
  # required by other manifests, such as `apache` and `mysql` and `apc`, so we
  # only list the ones that aren't already pulled in.
  #
  # You may want to modify this list for your app, or add a similar bit in your
  # own manifest, or even write a manifest for each package. The latter option
  # is preferable if you have any related configuration needs; see
  # squishy_v1::apc for an example.
  #
  $rpm_packages = [
    'php-gd',
    'php-pdo',
    'php-xml',
    'php-mbstring',
    'php-pecl-memcache',
    'memcached',
  ]

  # TODO: do this without breaking if other manifests declare these packages.
  package { $rpm_packages: ensure => 'installed' }
}
