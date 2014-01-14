# Define:
#
# Description
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define openldap::server::domain::overlay (
  $domain,
  $options = {},
) {
  concat::fragment { "openldap-domain-${domain}-overlay-${name}":
    target  => "openldap-domains",
    content => template('openldap/server/overlay.conf.erb'),
    order   => "${domain}-30",
  }
}
