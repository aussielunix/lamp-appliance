class apache::php {
  package { ['libapache2-mod-php5', 'php-pear']:
    ensure => installed,
  }
}
