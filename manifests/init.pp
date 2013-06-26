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
  package { 'apt-mirror':
    ensure => installed,
  }

  file { '/etc/apt/mirror.list':
    content => template('aptmirror/etc/apt/mirror.list'),
    mode    => '444'
  }

  Aptmirror::Source<| |> -> File['/etc/apt/mirror.list']
}
