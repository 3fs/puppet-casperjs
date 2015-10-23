# simple class that installs CasperJS
class casperjs (
  $package_version = '1.0.3', # set package version to download
  $source_url = undef,
  $source_dir = '/opt',
  $install_dir = '/usr/local/bin',
  $package_update = false,
  $timeout = 300
) {
  # Base requirements
  if $::kernel != 'Linux' {
    fail('This module is supported only on Linux.')
  }

  ensure_packages('curl')
  ensure_packages('unzip')

  $pkg_src_url = $source_url ? {
    undef   => "https://codeload.github.com/n1k0/casperjs/zip/${package_version}",
    default => $source_url,
  }

  exec { 'get casperjs':
    command => "/usr/bin/curl --silent --show-error ${source_url} --output ${source_dir}/casperjs.zip \
      && mkdir ${source_dir}/casperjs \
      && unzip ${source_dir}/casperjs.zip -d ${source_dir} \
      && mv ${source_dir}/casperjs-${package_version}/* ${source_dir}/casperjs/ \
      && rm -rf ${source_dir}/casperjs-${package_version}",
    creates => "${source_dir}/casperjs/",
    require => Package['curl', 'unzip'],
    timeout => $timeout,
  }

  file { "${install_dir}/casperjs":
    ensure => link,
    target => "${source_dir}/casperjs/bin/casperjs",
    force  => true,
  }

  if $package_update {
    exec { 'remove casperjs':
      command => "/bin/rm -rf ${source_dir}/casperjs",
      notify  => Exec[ 'get casperjs' ]
    }
  }
}
