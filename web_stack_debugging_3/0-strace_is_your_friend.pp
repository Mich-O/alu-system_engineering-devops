# This Puppet manifest restores a missing WordPress file that causes Apache to throw a 500 error

file { '/var/www/html/wp-settings.php':
  ensure => file,
  source => '/usr/share/wordpress/wp-settings.php',
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0644',
}
