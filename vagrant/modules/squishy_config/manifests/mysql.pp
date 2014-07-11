class squishy_config::mysql {
  include mysql
  

  # TODO: figure out how to set root password on first install
  # TODO: document / parameterize the root password 
  class { 'mysql::server':
    config_hash => {
      'bind_address' => '127.0.0.1',
      'root_password' => $mysql_root_password,
    }
  }
}
