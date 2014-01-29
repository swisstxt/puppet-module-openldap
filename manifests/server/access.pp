define openldap::server::access(
  $what,
  $grants,
  $order = 10,
  $domain = false,
) {
  concat::fragment { "openldap-accesses-${domain}-${name}":
    target  => $domain ? {
      false   => 'openldap-accesses',
      default => 'openldap-domains',
    },
    content => template('openldap/server/access.conf.erb'),
    order   => $domain ? {
      false   => $order,
      default => "${domain}-12-$order",
    },
  }
}
