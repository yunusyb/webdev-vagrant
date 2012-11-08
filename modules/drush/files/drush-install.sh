#!/bin/sh

/usr/bin/pear channel-update pear.php.net
/usr/bin/pear channel-discover pear.drush.org
/usr/bin/pear install drush/drush
/usr/bin/pear install Console_Table
