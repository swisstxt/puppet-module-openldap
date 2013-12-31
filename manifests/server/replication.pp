# Class:
#
# Description
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

define ldap::server::replication (
  $ensure = present,
  $provider = false,
  $consumer = false,
) {
  include ::ldap::params

  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    before  => Class['ldap::server::openldap::service'],
    require => Class['ldap::server::openldap::base'],
  }

  file { "${ldap::params::lp_openldap_var_dir}/${name}/accesslog":
    ensure => $ensure ? {
      present =>, directory,
      absent  => absent,
    },
    mode   => '0770',
    owner  => $ldap::params::lp_daemon_user,
  }
  file { "${ldap::params::lp_openldap_var_dir}/${name}/accesslog/DB_CONFIG":
    ensure  => $ensure,
    mode    => '0660',
    content => template('ldap/server/openldap/DB_CONFIG.erb')
  }
}
