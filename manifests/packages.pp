class colordiff         { package { 'colordiff': ensure => present, } }
class drush             { exec { "drush": command       => "pear channel-discover pear.drush.org
&& pear install drush/drush", } }
