class squishy_v1::shell_prompt {
  file { "/etc/profile.d/servertype-prompt.sh":
    mode => 644,
    owner => root,
    group => root,
    source => "puppet:///modules/squishy_v1/servertype-prompt.sh"
  }

  # add git status script for prompt
  file { "/usr/local/bin/git-prompt.sh":
    mode => 644,
    owner => root,
    group => root,
    source => "puppet:///modules/squishy_v1/git-prompt.sh"
  }

  # delete legacy name of this file
  file { "/etc/profile.d/squishy-servertype.sh":
    ensure => absent
  }
}
