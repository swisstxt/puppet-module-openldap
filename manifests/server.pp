# Class: ldap::server
#
# This module manages LDAP Server Configuration
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
# This class file is not used directly.
class ldap::server(
  $ssl       = false,
  $ssl_ca    = '',
  $ssl_cert  = '',
  $ssl_key   = '',
  $cn_config = undef,
  $rootdn    = undef,
  $rootpw    = undef,
) {
  anchor { 'ldap::server::begin': 
  } ->
  class { 'ldap::server::package':
    ssl     => $ssl,
  } ->
  class { 'ldap::server::config':
    ssl       => $ssl,
    ssl_ca    => $ssl_ca,
    ssl_cert  => $ssl_cert,
    ssl_key   => $ssl_key,
    cn_config => $cn_config,
    rootdn    => $rootdn,
    rootpw    => $rootpw,
  } ->
  class { 'ldap::server::rebuild':
  } ->
  class { 'ldap::server::service':
  } ->
  anchor { 'ldap::server::end': }
}
