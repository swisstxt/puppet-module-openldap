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
  $ssl      = false,
  $ssl_ca   = undef,
  $ssl_cert = undef,
  $ssl_key  = undef,
) {
  package { $::openldap::params::client_package:
    ensure => present,
  } ->
  file { '/etc/openldap/ldap.conf':
    content => template('openldap/client/ldap.conf.erb'),
  }
}
