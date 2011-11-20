class apache::install {
  package { [ 'apache2', 'apache2-mpm-prefork' ]:
    ensure => 'present',
  }
}
