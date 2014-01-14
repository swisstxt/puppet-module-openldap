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
# Sample Usage:
#
# Setup (Bootstrap) and Configuration of this module are currently
# separated in order to allow for multiple LDAP server definitions
# and multiple LDAP Trees being managed.
#
# Bootstrap:
# class { '::openldap':
#   server => true,
#   ssl    => false,
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
  $client         = false,
  $client_base    = undef,
  $client_uri     = undef,
  $server         = false,
  $server_use_olc = false,
  $server_rootdn  = undef,
  $server_rootpw  = undef,
  $server_options = {},
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
    rootdn    => $server_rootdn,
    rootpw    => $server_rootpw,
    use_olc   => $server_use_olc,
    options   => $options,
  }
}
