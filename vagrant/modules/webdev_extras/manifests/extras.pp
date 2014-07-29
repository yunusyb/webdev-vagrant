# a class for random extra resources that don't necessarily fit elsewhere

class webdev_extras::extras {

    package { 'vim-common':
        ensure => 'installed',
    }

    package { 'vim-enhanced':
        ensure => 'installed',
    }
    
    package { 'vim-minimal':
        ensure => 'installed',
    }


}

