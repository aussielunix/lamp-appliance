class mysql::install {
  package { ['mysql-server', 'mysql-client', 'maatkit' ]:
    ensure => present,
  }
}
