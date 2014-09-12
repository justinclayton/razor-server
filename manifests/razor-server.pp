  contain docker
  # at some point, docker started needing apparmor to start on ubuntu
  if $::osfamily == 'Debian' {
    package { 'apparmor': }
  }

  docker::image { '<insertsomethinglike--ham/razor-server--here':
    ensure     => 'latest',
    image_tag  => 'latest',
    require    => Class['docker'],
    before     => Docker::Run['razor-server_web'],
  }

  exec { 'stop_razor-server_web':
    command     => '/bin/bash -c \'THING=$(cat /var/run/docker-razor-server_web.cid) && /sbin/service docker-razor-server-web stop && /usr/bin/docker rm $THING\'',
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    refreshonly => true,
    subscribe   => Docker::Image['<insertsomethinglike-ham/razor-server-here'],
    before      => Docker::Run['razor-server_web'],
    onlyif      => 'test -e /var/run/docker-razor-server_web.cid && { ! (docker inspect --format "{{ .Image }}" razor-server_web | grep $(docker images | grep "<insertsomethinglike-ham/razor-server-here" | awk \'{ print $3 }\')) }',
  }

  ## resource defaults
  Docker::Run {
    use_name => true,
    require  => Class['docker'],
  }

  ## resources

  # web container
  # pulls from internal registry
  # links redis port from redis container
  # sets host to serve app on port 80
  docker::run { 'razor-server_web':
    image           => '<insertsomethinglike-ham/razor-server-here:latest',
    links           => ['razor-server_redis:redis'],
    volumes         => ['/vagrant:/opt/razor', '/etc/localtime:/etc/localtime:ro'],
    ports           => ['80:4567'],
  }