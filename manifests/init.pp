# Class: ldap
#
# This module manages LDAP Server and Clients.
#
# Parameters:
# *client* - Boolean flag (true|false) to configure an LDAP Client
# *server* - Boolean flag (true|false) to configure an LDAP Server
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
# Sample Usage:
#
# Setup (Bootstrap) and Configuration of this module are currently
# separated in order to allow for multiple LDAP server definitions
# and multiple LDAP Trees being managed.
#
# Bootstrap:
# class { '::openldap':
#   server => true,
# }
#
# Domain Configuration:
# ldap::server::domain {'example.com':
#   basedn   => 'dc=exmaple,dc=com',
#   rootdn   => 'cn=manager',
#   rootpw   => '{SSHA}drdxGXBfu+Z5z/ZwCnfwafsInSnq9MnD', # slappasswd -h '{SSHA}'
# }
#
class openldap(
  $client          = false,
  $client_base     = undef,
  $client_uri      = undef,
  $client_tls_ca   = undef,
  $client_tls_cert = undef,
  $client_tls_key  = undef,
  $server          = false,
  $server_rootdn   = undef,
  $server_rootpw   = undef,
  $server_options  = {},
  $server_tls_ca   = undef,
  $server_tls_cert = undef,
  $server_tls_key  = undef,
) inherits ::openldap::params {
  if $client {
    class { '::openldap::client':
      tls_ca    => $client_tls_ca,
      tls_cert  => $client_tls_cert,
      tls_key   => $client_tls_key,
    }
  }
  if $server {
    class { '::openldap::server':
      rootdn    => $server_rootdn,
      rootpw    => $server_rootpw,
      tls_ca    => $server_tls_ca,
      tls_cert  => $server_tls_cert,
      tls_key   => $server_tls_key,
      options   => $server_options,
    }
  }
}
