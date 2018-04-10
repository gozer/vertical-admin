file { '/etc/vertica.sql':
  ensure => present,
  owner  => root,
  group  => root,
  mode   => '0644',
  source => 'puppet:///nubis/files/schema.sql',
}

file { '/usr/local/bin/vertica-schema-diff':
  ensure => present,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/schema-diff',
}

# Periodically dump schems for comparaison
cron::daily { "${project_name}-schema-dump":
  command => "nubis-cron ${project_name}-schema-dump /usr/local/bin/vertica-schema-diff",
  user    => 'root',
}
