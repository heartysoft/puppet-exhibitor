class exhibitor::config(
  $opts = $exhibitor::opts,
  $properties = $exhibitor::properties,
  $install_dir = $exhibitor::install_dir
) inherits exhibitor::params {
  
  $merged_opts = merge($exhibitor::params::opts, $opts)
  $merged_properties = merge($exhibitor::params::properties, $properties)

  file { '/etc/default/exhibitor':
    ensure  => present,
    content => template('exhibitor/default.erb')
  }
  
  file { "${merged_opts['fsconfigdir']}/exhibitor.properties":
    ensure  => present,
    content => template('exhibitor/exhibitor.properties.erb') 
  }
}
