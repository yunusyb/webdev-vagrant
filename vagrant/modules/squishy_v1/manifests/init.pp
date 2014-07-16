class squishy_v1 {
  # http://itand.me/using-puppet-to-manage-users-passwords-and-ss

  define add_user ($email, $uid, $shell='/bin/bash') {
    $username = $title
    $rootgroup = 'root'

    user { $username:
      comment => "$email",
      home => "/home/$username",
      shell => $shell,
      uid => $uid,
      groups => ['squishydev', 'sudo', $rootgroup, ]
    }

    # Blank ("delete") users' passwords if they are unset.
    exec { "passwd -d $username":
      onlyif => "test \"`grep $username /etc/shadow | cut -d : -f 2`\" = '!!'",
      require => User[$username],
    }

    # Expire users' passwords if they are blank and not yet expired.
    #
    # Together with `passwd -d $username` above, this requires users to set a
    # password on first login, without having to know their first password.
    exec { "passwd -e $username":
      onlyif => "test \"`grep $username /etc/shadow | cut -d : -f 2`\" = '' && test \"`grep $username /etc/shadow | cut -d : -f 3`\" -ne 0",
      require => User[$username],
    }

    group { $username:
      gid => $uid,
      require => User[$username]
    }

    file { "/home/$username/":
      ensure => directory,
      owner => $username,
      group => $username,
      mode => 750,
      require => [User[$username], Group[$username]]
    }

    file {"/home/$username/.ssh":
      ensure => directory,
      owner => $username,
      group => $username,
      mode => 750,
      require => File["/home/$username/"]
    }

    # now make sure that the ssh key authorized files is around
    file { "/home/$username/.ssh/authorized_keys":
      ensure  => present,
      owner   => $username,
      group   => $username,
      mode    => 600,
      require => File["/home/$username/.ssh"]
    }
  }

  define add_ssh_key( $key, $type) {
    $username       = $title

    ssh_authorized_key{ "${username}_${key}":
      ensure  => present,
      key     => $key,
      type    => $type,
      user    => $username,
      require => File["/home/$username/.ssh/authorized_keys"]
    }

    # force users to change password when ssh key is created
    # need a better method, this expires every run and doesn't bootstrap passwordless users
    #exec {"passwordexpire_$username": command => "/usr/bin/chage -d 0 $username"}
  }
}
