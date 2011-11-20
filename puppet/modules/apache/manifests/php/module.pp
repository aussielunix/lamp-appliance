define apache::php::module($ensure='present') {
  case $ensure {
    present: {
      package {"php5-${name}":
        ensure  => present,
        require => Class['apache::php'],
        notify  => Class['apache::service'],
      }
    }
    absent: {
      package {"php5-${name}":
        ensure => absent,
        notify => Class['apache::service'],
      }
    }
    default: {
      fail "Invalid 'ensure' value ${ensure} for apache::php::module"
    }
  }
}
