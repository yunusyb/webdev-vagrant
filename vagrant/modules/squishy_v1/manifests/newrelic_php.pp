# == Class: squishy_v1::newrelic_php
#
# Currently very limited in scope; this is all we do:
# - Ensure the newrelic-php is installed
#
#
class squishy_v1::newrelic_php {
  package { 'newrelic-php5':
    ensure => 'latest',
  }
  package { 'newrelic-daemon':
    ensure  => 'latest',
  }
}
