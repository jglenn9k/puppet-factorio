# A description of what this class does
#
# @summary Install and manage Factorio headless server. See https://www.factorio.com/download-headless
#
# @example
#   include factorio
#
class factorio {
  group {'factorio':
    ensure => 'present',
    forcelocal => true,
  }
  user {'factorio':
    ensure => 'present',
    comment => 'Factorio Server',
    forcelocal => true,
    home => '/opt/factorio',
    shell => '/usr/sbin/nologin',
    require => Group['factorio'],
  }
  exec {'Download Factorio':
    command => 'wget https://www.factorio.com/get-download/stable/headless/linux64 -O /opt/factorio.tar.xz',
    creates => '/opt/factorio.tar.xz',
    cwd => '/opt',
    path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin',]
    user => 'root',
    require => User['factorio'],
  }
  exec {'Extract Factorio':
    command => 'tar xf /opt/factorio.tar.xz',
    creates => '/opt/factorio.tar.xz',
    cwd => '/opt',
    path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin',]
    user => 'root',
    require => Exce['Download Factorio'],
  }
}
