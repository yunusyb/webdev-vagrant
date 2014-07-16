# == Class: squishy_v1::newrelic_sysmon
#
# Currently very limited in scope; this is all we do:
# - Ensure the nrsysmond is installed
# - Ensure a basic config file is present
# - Add a daily cronjob to restart the newrelic daemon daily if it's present
#
# === Parameters
# *loglevel*:: nrsysmond logging level.  Defaults to "info"
#
class squishy_v1::newrelic_sysmon {
  $loglevel = hiera('squishy_v1::newrelic_sysmon::loglevel', 'info')
  if $operatingsystem == 'centos' {
    file { '/etc/newrelic/nrsysmond.cfg':
      content => template('squishy_v1/nrsysmond.cfg.erb'),
      mode => 644,
      owner => root,
      group => root,
    }

    file { '/etc/cron.daily/restart-newrelic.sh':
      source => 'puppet:///modules/squishy_v1/restart-newrelic.sh',
      owner => root,
      group => root,
      mode  => 700,
    }

    # New Relic repo
    yumrepo { "newrelic":
      baseurl =>  "http://yum.newrelic.com/pub/newrelic/el5/$architecture",
      descr =>  "New Relic packages for Enterprise Linux 5 - $architecture",
      enabled =>  1,
      gpgcheck  => 0,
    }

    package { 'newrelic-sysmond':
      ensure => 'latest',
    }
  }
}
