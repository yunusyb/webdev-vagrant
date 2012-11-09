# Download Drush from PECL

class drush {
    exec { "drush":
        command => "/vagrant/modules/drush/files/drush-install.sh",
        creates => "/usr/bin/drush",
    }
}

