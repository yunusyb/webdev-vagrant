node default inherits squishy-common {
}

node squishy-common {
    include git
    include epel
}

node /web.*/ inherits squishy-common {
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
}

node /db.*/ inherits squishy-common {
    include mysql
    class { 'mysql::server':
        config_hash => { 'root_password' => 'maZiib0bool4' }
    }
    file { 'my.cnf':
        path   => '/home/vagrant/.my.cnf',
        ensure => file,
        mode   => 0644,
        source => '/vagrant/files/my.cnf',
    }
}
