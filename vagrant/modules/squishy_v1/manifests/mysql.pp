class squishy_v1::mysql {
  # mytop should be installed
  package { 'mytop':
    ensure => 'latest'
  }

  # Most parameters are set in hiera, but in order to use hash merge lookup,
  # we have to query the override options directly.
  class { 'mysql::server':
    override_options => hiera_hash('mysql::server::override_options', {}),
    # TODO: add these when mysql module supports them (it's in master as of 12
    # Nov 13)
    #users => hiera_hash('mysql::server::users', {}),
    #grants => hiera_hash('mysql::server::grants', {}),
    #databases => hiera_hash('mysql::server::databases', {}),
  }

  # All parameters for this class are set in hiera.


# commented out vvvv for debugging purposes
#class { 'mysql::server::backup': }
}
