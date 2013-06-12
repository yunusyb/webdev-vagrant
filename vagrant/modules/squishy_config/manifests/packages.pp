class squishy_config::packages {
package {'iptables':
	ensure => 'installed',
}
package { "git":
	ensure => "latest",
}
package { "pwgen":
    ensure => "latest",
}
package { "screen":
    ensure => "latest",
}
package { "bison":
    ensure => "latest",
}
package { "byacc":
    ensure => "latest",
}
package { "cscope":
    ensure => "latest",
}
package { "ctags":
    ensure => "latest",
}
package { "cvs":
    ensure => "latest",
}
package { "diffstat":
    ensure => "latest",
}
package { "doxygen":
    ensure => "latest",
}
package { "flex":
    ensure => "latest",
}
package { "gcc":
    ensure => "latest",
}

$gccplusplus = $osfamily ? {
  'Debian' => 'g++',
  'RedHat' => 'gcc-c++',
}
package { $gccplusplus:
    ensure => "latest",
}

$gfortran = $osfamily ? {
  'Debian' => 'gfortran',
  'RedHat' => 'gcc-gfortran',
}
package { $gfortran:
    ensure => "latest",
}

package { "gettext":
    ensure => "latest",
}
package { "indent":
    ensure => "latest",
}
package { "intltool":
    ensure => "latest",
}
package { "libtool":
    ensure => "latest",
}
package { "patch":
    ensure => "latest",
}
package { "patchutils":
    ensure => "latest",
}
package { "rcs":
    ensure => "latest",
}

package { "subversion":
    ensure => "latest",
}
package { "swig":
    ensure => "latest",
}
package { "systemtap":
    ensure => "latest",
}
package { "tig":
    ensure => "latest",
    require => Class['epel'],
}

package { "zsh":
	ensure => "latest",
}

if $osfamily == 'RedHat' {
  package { "redhat-rpm-config":
      ensure => "latest",
  }
  package { "rpm-build":
      ensure => "latest",
  }
  package { "system-config-firewall":
	  ensure => "latest",
  }
  package { "openssl-devel":
	  ensure => "latest",
  }
  package { "pam-devel":
	  ensure => "latest",
  }
}

$augeas = $osfamily ? {
  'Debian' => 'augeas-tools',
  'RedHat' => 'augeas',
}
package { $augeas:
    ensure => "latest",
}

}

