class squishy_v1::php-fpm {
  #include 'squishy_v1::mysql'
  include 'squishy_v1::apc'
  include 'squishy_v1::newrelic_php'

  # add mysql bindings for PHP
  # TODO: abstract this out so that we can do both PHP and Python bindings on
  # the same box, for example.
  class { 'mysql::bindings':
    php_enable => true
  }

  include php::fpm::daemon
  php::fpm::conf { 'www':
      listen  => hiera('php::fpm::pool::listen', '127.0.0.1:9001'),
      user    => hiera('php::fpm::pool::user', 'apache'),
      pm_start_servers => hiera('php::fpm::pool::pm_start_servers', '2'),
      pm_min_spare_servers => hiera('php::fpm::pool::pm_min_spare_servers', '4'),
      pm_max_spare_servers => hiera('php::fpm::pool::pm_max_spare_servers', '4'),
      php_flag => {
          'newrelic.enabled' => 'on',
      },
      pm_max_children => hiera('php::fpm::pool::pm_max_children', '50'),
      pm_max_requests => hiera('php::fpm::pool::pm_max_requests', '5000'),
  }

  # fastcgi config
  file { '/etc/httpd/conf.d/fastcgi.conf':
         content => template('squishy_v1/fastcgi.conf.erb'),
         group => 'root',
         owner => 'root',
         mode => 'ug+w,o-w',
  }

  file { '/usr/lib/cgi-bin':
    ensure => directory,
  }

  # PHP ini
  augeas { '/etc/php.ini':
    notify  => Service['php-fpm'],
    context => "/files/etc/php.ini/PHP",
    changes => [
      'set memory_limit 512M',
      'set date.timezone PST8PDT',
      'set post_max_size 1024M',
      'set upload_max_filesize 1024M',
      'set magic_quotes_gpc Off',
      'set max_execution_time 240',
      'set max_input_time 240',
      'set mysql.allow_persistent Off',
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
    'mod_fastcgi',
  ]

  # TODO: do this without breaking if other manifests declare these packages.
  package { $rpm_packages: ensure => 'installed' }
}
