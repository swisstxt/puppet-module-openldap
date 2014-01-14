# Define: openldap::server::openldap::domain
#
# Parameters:
#
# *source* - Source of the schema file to manage
#
# Actions:
#
# Requires:
#
# Sample Usage:
# openldap::server::schema { 'websages':
#   source => 'puppet:///modules/profile_openldap/schema/extra.schema',
# }
define openldap::server::schema(
  $source,
) {
  file { "${::openldap::params::confdir}/schema/${name}.schema":
    source => $source,
  }
  concat::fragment { "openldap-schema-${name}":
    target  => 'openldap-schemas',
    content => "include ${::openldap::params::confdir}/schema/${name}.conf\n",
    notify => Service[$::openldap::params::service],
  }
}
