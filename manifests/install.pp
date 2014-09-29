class exhibitor::install(
  $version = $exhibitor::version,
  $install_source = $exhibitor::install_source,
  $install_dir = $exhibitor::install_dir,
  $install_method = $exhibitor::install_method
) {

  file { $install_dir:
    ensure => directory
  }

  if $install_method == 'cp' {
    file {"${install_dir}/exhibitor-${version}-jar-with-dependencies.jar" :
        ensure => present,
        source => "puppet:///modules/exhibitor/exhibitor-${version}-jar-with-dependencies.jar",
        mode => 744,
        require => File[$install_dir],
        before => File['/etc/init.d/exhibitor'],
    }
  } else {
    exec { 'download-exhibitor':
      command => "/usr/bin/wget -O ${install_dir}/exhibitor-${version}-jar-with-dependencies.jar ${install_source}/exhibitor-${version}-jar-with-dependencies.jar",
      creates => "${install_dir}/exhibitor-${version}-jar-with-dependencies.jar",
      require => File[$install_dir],
      before => File['/etc/init.d/exhibitor'],
    }
  }
}
