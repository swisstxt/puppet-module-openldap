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
class openldap(
  $client         = false,
  $client_base    = undef,
  $client_uri     = undef,
  $server         = false,
  $server_use_olc = false,
  $server_rootdn  = undef,
  $server_rootpw  = undef,
  $ssl            = false,
  $ssl_ca         = undef,
  $ssl_cert       = undef,
  $ssl_key        = undef,
) inherits ::openldap::params {
  class { '::openldap::client':
    ssl       => $ssl,
    ssl_ca    => $ssl_ca,
    ssl_cert  => $ssl_cert,
    ssl_key   => $ssl_key,
  }
  class { '::openldap::server':
    ssl       => $ssl,
    ssl_ca    => $ssl_ca,
    ssl_cert  => $ssl_cert,
    ssl_key   => $ssl_key,
    use_olc   => $server_use_olc,
    rootdn    => $server_rootdn,
    rootpw    => $server_rootpw,
  }
}
