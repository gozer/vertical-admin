class { 'java':
  distribution => 'jre',
}

file { '/etc/datacollector':
  ensure => directory
}
