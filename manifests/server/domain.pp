# Define: openldap::server::domain
#
# This custom definition sets up all of the necessary configuration
# Files to bootstrap a LDAP tree. This uses the File-Fragment
# pattern to break up and assemble various portions of the configuration.
#
# Parameters:
#
# *basedn* - Base DN for setting up the LDAP server.
# *rootdn* - Base DN for the administrator acount on an LDAP server.
# *rootpw* - Password for the administrator account. Will accept any valid
#          - Hashed (crypt|(s)md5|(s)sha) or plaintext password.
#
# Actions:
#
# Requires:
#
# Sample Usage:
# ldap::server::domain {'example.com':
#   basedn   => 'dc=exmaple,dc=com',
#   rootdn   => 'cn=manager',
#   rootpw   => '{SSHA}drdxGXBfu+Z5z/ZwCnfwafsInSnq9MnD', # slappasswd -h '{SSHA}'
# }
define openldap::server::domain(
  $basedn,
  $rootdn,
  $rootpw,
  $readdn = undef,
  $readpw = undef,
  $syncdn = undef,
  $syncpw = undef,
  $anonymous_read = true,
) {
  File {
    owner   => 'root',
    group   => $::openldap::params::group,
    mode    => '0640',
  }

  concat::fragment { "openldap-domain-${name}":
    target  => 'openldap-domains',
    content => template('openldap/server/domain.conf.erb'),
    order   => "${name}-10",
    notify  => Service[$::openldap::params::service],
  }

  Package[$::openldap::params::package] ->
  file { "${::openldap::params::vardir}/${name}":
    ensure  => directory,
    owner   => $::openldap::params::user,
    recurse => true,
  } ->
  file { "${::openldap::params::vardir}/${name}/DB_CONFIG":
    content => template('openldap/server/DB_CONFIG.erb'),
    owner   => $::openldap::params::user,
    notify  => Service[$::openldap::params::service],
  } ->
  file { "${::openldap::params::vardir}/${name}/base.ldif":
    content => template('openldap/server/base.ldif.erb'),
    owner   => $::openldap::params::user,
  } ->
  exec { "openldap-bootstrap-${name}":
    command => "/usr/sbin/slapadd -b '${basedn}' -v -l ${::openldap::params::vardir}/${name}/base.ldif",
    user    =>  $::openldap::params::user,
    group   =>  $::openldap::params::group,
    creates => "${::openldap::params::vardir}/${name}/id2entry.bdb",
    before  => Service[$::openldap::params::service],
  } <- Concat <| tag == 'openldap::server' |>
}
