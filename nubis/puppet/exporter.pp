$dbms_exporter_version = '0.0.1-nubis1'

notice ("Grabbing dbms_exporter ${dbms_exporter_version}")

$dbms_exporter_url = "https://github.com/gozer/dbms_exporter/releases/download/${dbms_exporter_version}/dbms_exporter-${dbms_exporter_version}"

staging::file { '/usr/local/bin/dbms_exporter':
  source => $dbms_exporter_url,
  target => '/usr/local/bin/dbms_exporter',
}
-> exec { 'chmod /usr/local/bin/dbms_exporter':
  command => 'chmod 755 /usr/local/bin/dbms_exporter',
  path    => ['/sbin','/bin','/usr/sbin','/usr/bin','/usr/local/sbin','/usr/local/bin'],
}

file {'/etc/dbms_exporter':
  ensure => directory,
}

file {'/etc/dbms_exporter/query.yaml':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0644',
  source => 'puppet:///nubis/files/query.yaml',
}

systemd::unit_file { 'dbms_exporter.service':
  content => @("EOT")
[Unit]
Description=Prometheus DBMS Exporter
Wants=basic.target
After=basic.target network.target

[Service]
Restart=on-failure
RestartSec=10s

Environment=DATA_SOURCE_NAME=DSN=metrics

ExecStart=/usr/local/bin/dbms_exporter -driver odbc -queryfile /etc/dbms_exporter/query.yaml

EOT
} ~> service { 'dbms_exporter':
  ensure => 'stopped',
  enable => false,
}
