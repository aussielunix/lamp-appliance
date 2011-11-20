class postfix {
  include postfix::install, postfix::config, postfix::service

  exec { 'newaliases':
    refreshonly => true,
  }
}
