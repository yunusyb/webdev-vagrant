# add mysql-client configs
file { 'my.cnf':
    path   => '/home/vagrant/.my.cnf',
    ensure => file,
    mode   => 0644,
    source => '/vagrant/files/my.cnf',
}

# mysql-server config
class { 'mysql::server':
    config_hash => { 'root_password' => 'maZiib0bool4' }
}

mysql::db { 'squishydev':
    user        => 'squishydev',
    password    => 'squishydev',
    host        => 'localhost',
    grant       => ['all'],
}

# Apache config
firewall { "000 allow http":
    proto  => 'tcp',
    port   => '80',
    action => 'accept',
}
file { '/server':
    ensure => directory,
    mode   => 2775,
    owner  => 'vagrant',
    group  => 'vagrant',
}
file { '/server/htdocs':
    ensure => directory,
    mode   => 2775,
    owner  => 'vagrant',
    group  => 'vagrant',
}
file { '/server/htdocs/index.php':
    ensure => file,
    mode   => 0644,
    source => '/vagrant/files/index.php',
    owner  => 'vagrant',
    group  => 'vagrant',
}

# PHP config
php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
}
php::module::ini { 'pecl-apc':
    settings           => {
        'apc.enabled'  => '1',
        'apc.shm_size' => '128m',
    }
}
