#!/usr/bin/env ruby

set :user, 'root'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

host = ENV['HOST']
host ||= 'lamp-dev-01'


namespace :puppet do

  desc 'prep dev server via rsync'
  task :prepd, :hosts => host do
    options = ENV['options'] || ENV['OPTIONS']
    lines = ['deb http://apt.puppetlabs.com/ubuntu lucid main',
        'deb-src http://apt.puppetlabs.com/ubuntu lucid main',
        '']
    put lines.join('\n'), '/tmp/puppetlabs.list.new'
    run 'mv /tmp/puppetlabs.list.new /etc/apt/sources.list.d/puppetlabs.list'
    run 'apt-key adv --keyserver keyserver.ubuntu.com --recv 4BD6EC30'
    run 'apt-get update'
    run 'apt-get install -y puppet git-core'
    `rsync -avz --delete -e ssh . #{user}@#{host}:/opt/build`
  end

  desc 'prep server for puppet run - git clone etc'
  task :prep, :hosts => host do
      options = ENV['options'] || ENV['OPTIONS']
      lines = ['deb http://apt.puppetlabs.com/ubuntu lucid main',
          'deb-src http://apt.puppetlabs.com/ubuntu lucid main',
          '']
      put lines.join("\n"), '/tmp/puppetlabs.list.new'
      run 'mv /tmp/puppetlabs.list.new /etc/apt/sources.list.d/puppetlabs.list'
      run 'apt-key adv --keyserver keyserver.ubuntu.com --recv 4BD6EC30'
      run 'apt-get update'
      run 'apt-get install -y puppet git-core'
      run 'git clone https://bitbucket.org/aussielunix/lamp2-appliance.git /opt/build'
  end

  desc 'update puppet repos on dev server - rsync'
  task :upd, :hosts => host do
    options = ENV['options'] || ENV['OPTIONS']
    `rsync -avz --delete -e ssh . #{user}@#{host}:/opt/build`
  end

  desc 'update puppet repos from bitbucket'
  task :up, :hosts => host do
    options = ENV['options'] || ENV['OPTIONS']
    run "cd /opt/build && git pull"
  end

  desc 'runs puppet apply on remote host - Params:  HOST OPTIONS'
  task :go, :hosts => host do
    options = ENV['options'] || ENV['OPTIONS']
    run "puppet apply --verbose /opt/build/puppet/init.pp --modulepath=/opt/build/puppet/modules #{options}"
  end

end

