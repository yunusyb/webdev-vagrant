node default {
    include git
    include mysql
    include apache
    include php::cli
    include php::mod_php5
    php::module { [ 'pecl-apc', 'pecl-memcached', 'pdo', 'gd', 'mbstring' ]: }
    include mysql
}
