define openldap::server::access(
  $what,
  $grants,
  $order = 10,
) {
  concat::fragment { "openldap-accesses-${name}":
    target  => 'openldap-accesses',
    content => template('openldap/server/access.conf.erb'),
    order   => $order,
  }
}
