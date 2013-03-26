# puppet-aptmirror

## Usage

```puppet
class { 'aptmirror': }

aptmirror::source { 'http://us.archive.ubuntu.com':
  amd64         => true,
  clean         => true,
  source        => true,
  distributions => [
    'precise',
    'precise-updates',
    'precise-security',
    'precise-backports',
  ],
  components    => [
    'main',
    'restricted',
    'universe',
    'multiverse',
  ],
}
```

## Classes
### aptmirror
 * **base_path         -** 
 * **mirror_path       -**
 * **skel_path         -**
 * **var_path          -**
 * **cleanscript       -**
 * **postmirror_script -**
 * **defaultarch       -**
 * **run_postmirror    -**
 * **nthreads          -**
 * **_tilde            -**

## Defined Types
### aptmirror::source
 * **namevar       -** The URL of the repository to mirror.
 * **distributions -** An array of apt repository distributions to mirror.
 * **components    -** An array of apt repository components to mirror.
 * **clean         -** Set to `true` to enable cleaning of old packages from
                       this source from the mirror. Defaults to `false`.
 * **amd64         -** Set to `true` to enable mirroring of the amd64 packages.
                       Defaults to `false`.
 * **i386          -** Set to `true` to enable mirroring of the i386 packages.
                       Defaults to `false`.
 * **source        -** Set to `true` to enable mirroring of the dpkg source
                       files. Defaults to `false`.
