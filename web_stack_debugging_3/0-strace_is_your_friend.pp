# Fix the WordPress installation causing Apache to return 500 errors

exec { 'fix-wordpress':
  command => '/bin/sed -i "s/;$/;/" /var/www/html/wp-config.php',
  onlyif  => '/bin/grep -q "DB_PASSWORD" /var/www/html/wp-config.php',
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => Exec['fix-wordpress'],
}
