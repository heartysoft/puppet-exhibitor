class exhibitor::service(
  $install_dir = $exhibitor::install_dir,
  $config_dir = $exhibitor::config_dir
) {

  file { '/etc/init.d/exhibitor':
    ensure  => present,
    content => template('exhibitor/init.d.erb'),
    mode    => '0755',
  }

  service { 'exhibitor':
    ensure => 'running',
    enable => true,
    require => File['/etc/init.d/exhibitor']
  }
}
