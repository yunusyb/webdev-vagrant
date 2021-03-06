# == Define Resource Type: apache::balancer
#
# This type will create an apache balancer cluster file inside the conf.d
# directory. Each balancer cluster needs one or more balancer members (that can
# be declared with the apache::balancermember defined resource type). Using
# storeconfigs, you can export the apache::balancermember resources on all
# balancer members, and then collect them on a single apache load balancer
# server.
#
# === Requirement/Dependencies:
#
# Currently requires the ripienaar/concat module on the Puppet Forge and uses
# storeconfigs on the Puppet Master to export/collect resources from all
# balancer members.
#
# === Parameters
#
# [*name*]
# The namevar of the defined resource type is the balancer clusters name.
# This name is also used in the name of the conf.d file
#
# [*collect_exported*]
# Boolean, default 'true'. True means 'collect exported @@balancermember
# resources' (for the case when every balancermember node exports itself),
# false means 'rely on the existing declared balancermember resources' (for the
# case when you know the full set of balancermembers in advance and use
# apache::balancermember with array arguments, which allows you to deploy
# everything in 1 run)
#
#
# === Examples
#
# Exporting the resource for a balancer member:
#
# apache::balancer { 'puppet00': }
#
define apache::balancer (
  $collect_exported = true,
) {
  include concat::setup

  $target = "${::apache::params::confd_dir}/balancer_${name}.conf"

  concat { $target:
    owner  => '0',
    group  => '0',
    mode   => '0644',
    notify => Service['httpd'],
  }

  concat::fragment { '00-header':
    target  => $target,
    order   => '01',
    content => "<Proxy balancer://${name}>\n",
  }

  if $collect_exported {
    Apache::Balancermember <<| balancer_cluster == $name |>>
  }
  # else: the resources have been created and they introduced their
  # concat fragments. We don't have to do anything about them.

  concat::fragment { '01-footer':
    target  => $target,
    order   => '20',
    content => "</Proxy>\n",
  }
}
