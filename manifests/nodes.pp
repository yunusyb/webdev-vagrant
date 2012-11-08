node default {
    #include git
    #include epel
    # add mysql-client and configs
    include mysql
    file { 'my.cnf':
        path   => '/home/vagrant/.my.cnf',
        ensure => file,
        mode   => 0644,
        source => '/vagrant/files/my.cnf',
    }
    # Apache config
    include apache
    firewall { "000 accept http":
        proto  => 'tcp',
        port   => '80',
        action => 'accept',
    }
    # PHP config
    include php::cli
    #include php::mod_php5
    php::ini { '/etc/php.ini':
        display_errors => 'On',
        memory_limit   => '256M',
    }
    php::module { [ 'pecl-apc', 'pecl-memcached' ]: }
    php::module::ini { 'pecl-apc':
        settings           => {
            'apc.enabled'  => '1',
            'apc.shm_size' => '128m',
        }
    }
    include mysql
    class { 'mysql::server':
        config_hash => { 'root_password' => 'maZiib0bool4' }
    }
    firewall { "001 accept mysql":
        proto  => 'tcp',
        port   => '3306',
        action => 'accept',
    }
}
