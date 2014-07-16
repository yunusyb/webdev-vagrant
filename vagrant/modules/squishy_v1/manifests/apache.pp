class squishy_v1::apache {
  $vhosts_d = $osfamily ? {
    'RedHat' => "/etc/httpd/vhosts.d",
    'Debian' => "/etc/apache2/sites-available",
  }

  class { '::apache':
    default_mods => false,
    default_vhost => false,
    default_ssl_vhost => false,
    vhost_dir => $vhosts_d,
    service_enable => true,
  }

  package { 'cronolog':
    ensure => 'latest',
  }

  # We have to list apache modules manually because we are turning down the
  # default modules in the block above.
  include ::apache::mod::mime
  include ::apache::mod::alias
  include ::apache::mod::dir
  include ::apache::mod::rewrite
  include ::apache::mod::auth_basic
  include ::apache::mod::headers
  apache::mod { 'actions': }
  apache::mod { 'expires': }
  apache::mod { 'deflate': }
  apache::mod { 'authn_file': }
  apache::mod { 'authz_user': }

  if (!$vagrant) {
    file { '/server':
      ensure	=> directory,
      mode	=> 2775,
      owner	=> 'root',
      group	=> 'squishydev',
    }
    file { '/server/www/':
      ensure => directory,
      mode   => 2775,
      owner  => 'root',
      group  => 'squishydev',
    }
  }
}
