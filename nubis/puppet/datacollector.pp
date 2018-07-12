file { '/opt/mi':
  ensure => directory,
  owner  => 'root',
  group  => 'root',
}

file { '/opt/mi/datacollector':
  ensure  => directory,
  recurse => true,
  purge   => false,
  owner   => 'root',
  group   => 'root',
  source  => 'puppet:///nubis/files/datacollector',
  require => [
    File['/opt/mi'],
  ],
}
