include nubis_discovery
nubis::discovery::service { $project_name:
  tags     => [ '%%PURPOSE%%' ],
  tcp      => 22,
  interval => '30s',
}

nubis::discovery::service { 'vertica-metrics':
  tags     => [ 'metrics' ],
  http     => 'http://localhost:9113',
  port     => 9113,
  interval => '30s',
}
