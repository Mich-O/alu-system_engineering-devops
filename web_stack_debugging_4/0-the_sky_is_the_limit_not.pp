# Fix Nginx configuration to prevent truncated responses under high concurrency
package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  require   => Package['nginx'],
}

exec { 'tune-nginx-for-benchmarks':
  command => "/bin/sed -i 's/sendfile on;/sendfile off;/' /etc/nginx/nginx.conf \
             && /bin/sed -i 's/worker_processes .*/worker_processes auto;/' /etc/nginx/nginx.conf \
             && /bin/sed -i 's/worker_connections [0-9]\\+/worker_connections 1024;/' /etc/nginx/nginx.conf || true \
             && /usr/sbin/service nginx restart",
  onlyif  => "/bin/grep -q 'sendfile on;' /etc/nginx/nginx.conf || ! /bin/grep -q 'worker_processes auto;' /etc/nginx/nginx.conf",
  require => Package['nginx'],
  notify  => Service['nginx'],
}
