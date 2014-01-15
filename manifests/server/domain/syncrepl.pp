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
define openldap::server::domain::syncrepl (
  $domain,
  $rid,
  $options = {},
  $mirrormode = false,
) {
  concat::fragment { "openldap-domain-${domain}-syncrepl":
    target  => "openldap-domains",
    content => template('openldap/server/syncrepl.conf.erb'),
    order   => "${domain}-20",
  }
}
