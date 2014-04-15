class aptmirror(
    $base_path         = '/var/spool/apt-mirror',
    $mirror_path       = '$base_path/mirror',
    $skel_path         = '$base_path/skel',
    $var_path          = '$base_path/var',
    $cleanscript       = '$base_path/clean.sh',
    $postmirror_script = '$var_path/postmirror.sh',
    $defaultarch       = 'amd64',
    $run_postmirror    = '0',
    $nthreads          = '20',
    $_tilde            = '0',
  ) {
  $mirrorlist = '/etc/apt/mirror.list'

  package { 'apt-mirror':
    ensure => installed,
  }

  concat { $mirrorlist:
  }

  concat::fragment { 'aptmirror_list_header':
    target  => $mirrorlist,
    content => template('aptmirror/etc/apt/mirror.list.header'),
    order   => '01',
  }
}
