$mysql_root_password = 'root'

include squishy_config::minimum
include squishy_config::lamp
include squishy_config::mysql
include squishy_config::drupal

apache::vhost { 'vagrant':
  priority    => '10',
  port        => '80',
  docroot     => '/server/htdocs'
  override    => ['all'],
  directories => [ { path => [ '/server/htdocs', allow_override => ['All'] ] }, ]
  custom_fragment => "<Directory ~ 'sites/[^/]+/files/'>
    AllowOverride None
    #Prevent executable PHP in uploaded files
    php_admin_flag engine off
  </Directory>",
}

# this directive ensures that apache::vhost doesn't clobber our docroot.
file { '/server/htdocs':
  ensure => 'link',
}

# a few vagrant-specific php.ini settings
augeas { 'vagrant_php.ini':
  context => "/files/etc/php.ini",
  changes => [
    'set PHP/display_errors On',
    'set PHP/display_startup_errors On',
    'set PHP/error_reporting "E_ALL | E_STRICT',
  ],
}

# insecure settings for ssh client within vagrant
augeas { 'ssh_config':
  context => "/files/etc/ssh/ssh_config",
  changes => [
    "set Host *",
    "set Host[.='*']/StrictHostKeyChecking no",
    "set Host[.='*']/User $vagrant_ssh_user",
  ],
  require => File['/usr/share/augeas/lenses/ssh.aug'],
}
