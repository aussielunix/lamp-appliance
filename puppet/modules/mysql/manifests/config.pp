class mysql::config {
  file {'/etc/mysql/my.cnf':
    ensure  => present,
    source  => 'puppet:///modules/mysql/my.cnf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['mysql::install'],
    notify  => Class['mysql::service'],
  }
}
