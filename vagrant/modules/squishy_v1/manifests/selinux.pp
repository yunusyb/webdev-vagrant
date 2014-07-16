class squishy_v1::selinux {

  augeas { "selinux_config":
    context => "/files/etc/sysconfig/selinux",
    changes => [
      "set SELINUX disabled"
    ],
  }

  # Throws errors randomly on servers, not mandatory if above works
  # file { "/selinux/enforce":
  #  ensure => absent,
  #}
}
