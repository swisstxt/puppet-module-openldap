# Class: ldap
#
# This module manages LDAP Server and Clients.
#
# Parameters:
# *client* - Boolean flag (true|false) to configure an LDAP Client
# *server* - Boolean flag (true|false) to configure an LDAP Server
# *ssl*    - Boolean flag (true|false) to enable SSL Support
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged LDAP
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
# Sample Usage:
#
# Setup (Bootstrap) and Configuration of this module are currently
# separated in order to allow for multiple LDAP server definitions
# and multiple LDAP Trees being managed.
#
# Bootstrap:
# node 'server.puppetlabs.test' {
#   class { 'ldap':
#     server      => true,
#     ssl         => false,
#   }
# }
# node 'client.puppetlabs.test' {
#   class {'ldap':
#     client  => true,
#     ssl     => false,
#   }
# }
#
# Server Configuration:
# ldap::define::domain {'puppetlabs.test':
#   basedn   => 'dc=puppetlabs,dc=test',
#   rootdn   => 'cn=admin',
#   rootpw   => 'test',
# }
#
# Client Configuration:
# ldap::client::config { 'puppetlabs.test':
#   ensure  => 'present',
#   servers => 'server',
#   ssl     => false,
#   base_dn => 'dc=puppetlabs,dc=test',
# }
class ldap(
  $client      = false,
  $server      = false,
  $ssl         = false,
  $ssl_ca      = '',
  $ssl_cert    = '',
  $ssl_key     = '',
  $cn_config   = false,
  $rootdn      = undef,
  $rootpw      = undef,
) {
  include stdlib
  include ldap::params

  # ensure relationships of contained classes
  anchor { 'ldap::begin': } ->
  anchor { 'ldap::begin::client': } ->
  anchor { 'ldap::end::client': } ->
  anchor { 'ldap::begin::server': } ->
  anchor { 'ldap::end::server': } ->
  anchor { 'ldap::end': }

  # Client Specific Information
  if $client {
    class { 'ldap::client':
      ensure  => 'present',
      ssl     => $ssl,
      require => Anchor['ldap::begin::client'],
      before  => Anchor['ldap::end::client'],
    }
  }

  # Server Specific Information
  if $server {
    class { 'ldap::server':
      ssl       => $ssl,
      ssl_ca    => $ssl_ca,
      ssl_cert  => $ssl_cert,
      ssl_key   => $ssl_key,
      cn_config => $cn_config,
      rootdn    => $rootdn,
      rootpw    => $rootpw,
      require   => Anchor['ldap::begin::server'],
      before    => Anchor['ldap::end::server'],
    }
  }
}
