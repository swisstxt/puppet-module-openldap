# Define: openldap::server::openldap::domain
#
# This custom definition sets up all of the necessary configuration
# Files to include custom schema in OpenLDAP. This uses the File-Fragment
# pattern to break up and assemble various portions of the configuration.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes.
# *source* - Source file for processing by Puppet
#
# Actions:
#
# This definition acts as a proxy class to various server implementations
#
# Requires:
#
# Sample Usage:
# Server Configuration:
# openldap::server::schema { 'websages':
#   ensure => 'present',
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
