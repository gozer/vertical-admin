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
