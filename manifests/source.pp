define aptmirror::source(
    $distributions,
    $components,
    $url    = $name,
    $clean  = false,
    $amd64  = true,
    $i386   = false,
    $source = true,
  ) {
  validate_array($distributions)
  validate_array($components)
  validate_bool($clean)
  validate_bool($amd64)
  validate_bool($i386)
  validate_bool($source)
  validate_string($url)
}
