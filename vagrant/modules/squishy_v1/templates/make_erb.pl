#!/usr/bin/perl -w
# Simple script to generate erb from xdebug.ini
#
# The resulting file should be cleaned up, especially for xdebug.dump.*
#
# Orignal source file from:
#   https://raw.github.com/derickr/xdebug/master/xdebug.inia
#

use File::Basename;

$basename = basename($ARGV[0], '.ini');
while (<>) {
  print;
  if (m/^;($basename\.(\S+)\s*=\s*)/) {
    $assignment = $1; # LHS and equals sign, with spaces.
    $erb_var_name = "${basename}_$2";
    chomp $assignment; # remove trailing newline, if it exists
    print "<%- if \@$erb_var_name -%>\n";
    print "$assignment<%= \@$erb_var_name %>\n";
    print "<%- end -%>\n";
  }
}
