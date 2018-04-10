file { '/etc/vertica.sql':
  ensure => present,
  owner  => root,
  group  => root,
  mode   => '0644',
  source => 'puppet:///nubis/files/schema.sql',
}

# Periodically dump schems for comparaison
cron::daily { "${project_name}-schema-dump":
  command => "nubis-cron ${project_name}-schema-dump /opt/vertica/bin/vsql -qt -o /tmp/vertica.sql -h $(nubis-metadata NUBIS_ENVIRONMENT).vertical.service.consul -U dbadmin -c \\\"select export_catalog('','design_all');\\\"",
  user    => 'root',
}
