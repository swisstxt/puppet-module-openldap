# Class: openldap::params
#
# This module manages LDAP paramaters
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
class openldap::params {
  # client
  $client_sizelimit = 0
  $client_timelimit = 0
  $client_deref = 'never'

  $client_package = $::osfamily ? {
    'Debian' => 'ldap-utils',
    default  => 'openldap-clients',
  }

  # server
  $loglevel = 8
  $sizelimit = 5000
  $tool_threads = 1
  $database = 'bdb'

  $user = $::osfamily ? {
    'Debian' => 'openldap',
    default  => 'ldap',
  }
  $group = $::osfamily ? {
    'Debian' => 'openldap',
    default  => 'ldap',
  }
  $confdir = $::osfamily ? {
    'Debian' => '/etc/ldap',
    default  => '/etc/openldap',
  }
  $vardir = $::osfamily ? {
    'Debian' => '/var/lib/slapd',
    default  => '/var/lib/ldap',
  }
  $rundir = $::osfamily ? {
    'Debian' => '/var/run/slapd',
    default  => '/var/run/openldap',
  }
  $modulepath = $::osfamily ? {
    'Debian' => '/usr/lib/ldap',
    default  => false,
  }
  $package = $::osfamily ? {
    'Debian' => 'slapd',
    'Redhat' => 'openldap-servers',
  }
  $service = $::osfamily ? {
    'Debian' => 'slapd',
    'Redhat' => $::lsbmajdistrelease ? {
      5 => 'ldap',
      6 => 'slapd',
    }
  }
}
