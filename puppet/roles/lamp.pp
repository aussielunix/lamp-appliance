define lamp( $rootmail='mick@example.com', $webmaster='mick@example.com' ) {

  include git
  include motd
  include postfix
  include apache
  include mysql
  include apache::php

  postfix::alias { 'webmaster':
    ensure    => 'present',
    recipient => 'root',
  }

  postfix::alias { 'postmaster':
    ensure    => 'present',
    recipient => 'root',
  }

  postfix::alias { 'root':
    ensure    => 'present',
    recipient => $rootmail,
  }

  a2mod { 'php5':
    ensure => present,
  }

  apache::php::module { 'mysql': }
  apache::php::module { 'curl': }
  apache::php::module { 'gd': }
  apache::php::module { 'sqlite': }
  apache::php::module { 'memcache': }
  apache::php::module { 'mcrypt': }
  apache::php::module { 'imagick': }

  apache::site { $name:
    ensure    => 'present',
    webmaster => $webmaster,
    priority  => '010',
  }

  apache::site { 'default':
    ensure   => 'absent',
    priority => '000',
  }
}
