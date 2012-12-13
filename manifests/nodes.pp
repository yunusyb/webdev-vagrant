node /^web\d+/ {
	include apache
	include php::mod_php5
	php::module { [ 'pecl-apc', 'pecl-memcached', 'pdo', 'gd', 'mbstring', 'xml' ]: }
	include git
}

node /^database\d+/ {
	include mysql
	# mysql-server config
	class { 'mysql::server':
	    config_hash => { 'root_password' => 'maZiib0bool4' }
	}
	mysql::db { 'squishydev':
	    user     => 'squishydev',
	    password => 'squishydev',
	    host     => 'localhost',
	    grant    => ['all'],
	}
	include git
}

node default {
	include git
}
