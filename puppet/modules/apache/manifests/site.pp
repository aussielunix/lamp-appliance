define apache::site($ensure, $webmaster='', $priority='000') {
  case $ensure {
    present: {
      file { "/etc/apache2/sites-available/$name":
        mode    => '0644',
        content => template('apache/vhost.erb'),
        require => Class['apache::install'],
      }
      file { "/etc/apache2/sites-enabled/${priority}-${name}":
        ensure  => link,
        target  => "/etc/apache2/sites-available/${name}",
        require => File["/etc/apache2/sites-available/$name"],
        notify  => Class['apache::service'],
      }
      file { "/var/www/${name}":
        ensure  => directory,
        mode    => '0775',
        owner   => 'root',
        group   => 'www-data',
        require => Class['apache::install'],
      }
      file { "/var/www/${name}/htdocs":
        ensure  => directory,
        mode    => '0775',
        owner   => 'root',
        group   => 'www-data',
        require => File["/var/www/${name}"],
      }
      file { "/var/www/${name}/htdocs/index.html":
        ensure  => file,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        content => "Welcome to ${name}\n",
        require => File["/var/www/${name}/htdocs"],
      }
    }

    absent: {
      notify { "removing site ${priority}-${name}": }

      file { "/etc/apache2/sites-enabled/${priority}-${name}":
        ensure => 'absent',
        notify => Class['apache::service']
      }
      file { "/etc/apache2/sites-available/${name}":
        ensure => 'absent',
        notify => Class['apache::service']
      }
    }

    default: {
      fail "Invalid 'ensure' value ${ensure} for apache::site"
    }
  }
}
