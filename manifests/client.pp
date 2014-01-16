# Class: openldap::client
#
# This module manages LDAP client Configuration
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class openldap::client(
  $base     = undef,
  $uri      = undef,
  $tls_ca   = undef,
  $tls_cert = undef,
  $tls_key  = undef,
) {
  package { $::openldap::params::client_package:
    ensure => present,
  } ->
  file{ '/etc/openldap':
    ensure => directory,
  } ->
  file { '/etc/openldap/ldap.conf':
    content => template('openldap/client/ldap.conf.erb'),
  }
}
