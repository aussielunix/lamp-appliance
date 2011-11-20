class postfix::install {
  package { ['postfix', 'bsd-mailx' ]:
    ensure => present,
  }
}
