**NOTE: This repository is no longer supported or updated by GitHub. If you wish to continue to develop this code yourself, we recommend you fork it.**

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
 * **base_path         -** The base path on disk where apt-mirror will store
                           its data. Defaults to `/var/spool/apt-mirror`.
 * **mirror_path       -** The path on disk where the packages will be stored.
                           Defaults to `$base_path/mirror`.
 * **skel_path         -** The path on disk where the downloaded indexes will
                           be temporarily stored. Defaults to
                           `$base_path/skel`.
 * **var_path          -** The path on disk where the log files and MD5 sums
                           will be stored. Defaults to `$base_path/var`.
 * **cleanscript       -** The path to the mirror cleaning script. Defaults to
                           `$var_path/clean.sh`.
 * **postmirror_script -** The path to the script that will run after the
                           mirror process has finished. Defaults to
                           `$var_path/postmirror.sh`.
 * **defaultarch       -** The architecture to pull down if you don't specify
                           an architecture in your `aptmirror::sources`.
                           Defaults to `amd64`.
 * **run_postmirror    -** Set to `1` to run the postmirror script after the
                           mirror has finished syncing. Defaults to `0`.
 * **nthreads          -** The number of threads apt-mirror should run.
                           Defaults to `20`.
 * **_tilde            -** Set to `1` to skip packages that contain a tilde
                           (`~`). Defaults to `0`.

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

## Here Be Dragons
This module works through some interesting catalogue hackery. The
`aptmirror::source` defined type doesn't actually do anything, it just acts as
way to store data about the sources in your Puppet catalogue. In the
`/etc/apt/mirror.list` template, we inspect the catalogue, pull out all the
`aptmirror::source` instances and use their values to populate the template.
This is done so that you can specify `aptmirror::source` dynamically anywhere
in your manifests without having to go back and modify a static list of sources
in the `aptmirror` class definition.
