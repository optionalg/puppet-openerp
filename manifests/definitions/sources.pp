define openerp::sources ($ensure=present,$basedir,$url,$owner,$group,$mode=2775) {
  case $ensure {
    "present": {
      exec {"bzr branch $name from $url to ${basedir}${name}":
        command => "su -c \"bzr co ${url} ${basedir}${name}\" ${owner}",
        timeout => 180,
        require => [ File["${basedir}${name}"], User["openerp"], Class["bazaar::client"]],
        creates => "${basedir}${name}/.bzr"
      }
      file {"${basedir}${name}":
        ensure => directory,
        mode   => $mode,
        owner  => $owner,
        group  => $group,
      }
    }
    "absent": {
      file {"${basedire}/${name}":
        ensure  => absent,
        force   => true,
        backup  => false,
      }
    }
    default: {
      fail "Uknown ensure method: $ensure for openerp::release $name"
    }
  }
}