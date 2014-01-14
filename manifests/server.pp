# Class: openldap::server
#
# This class manages OpenLDAP server configuration
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class openldap::server(
  $ssl      = false,
  $ssl_ca   = undef,
  $ssl_cert = undef,
  $ssl_key  = undef,
  $use_olc  = undef,
  $rootdn   = undef,
  $rootpw   = undef,
  $options  = {},
) {
  File {
    owner => root,
    group => $::openldap::params::group,
    mode  => '0640',
  }
  Concat {
    force => true,
    owner => root,
    group => $::openldap::params::group,
    mode  => '0640',
  }

  package { $::openldap::params::package:
    ensure => present,
  } -> 
  file { "${::openldap::params::confdir}/slapd.conf":
    content => template('openldap/server/slapd.conf.erb'),
  } ->
  concat { 'openldap-schemas':
    path => "${::openldap::params::confdir}/schemas.conf",
  } ->
  concat { 'openldap-accesses':
    path => "${::openldap::params::confdir}/accesses.conf",
  } ->
  concat { 'openldap-domains':
    path => "${::openldap::params::confdir}/domains.conf",
  } ->
  file { "${::openldap::params::confdir}/schema":
    ensure  => directory,
  } ->
  file { "${::openldap::params::confdir}/slapd.d":
    ensure  => absent,
    force   => true,
  } ->
  service { $::openldap::params::service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
