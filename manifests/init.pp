class casperjs (
  $package_version = '1.0.3', # set package version to download
  $source_url = "https://codeload.github.com/n1k0/casperjs/legacy.zip/$package_version",
  $source_dir = '/opt',
  $install_dir = '/usr/local/bin',
  $package_update = false,

) {
  exec { 'get casperjs':
    command => "/usr/bin/curl --silent --show-error $source_url --output $source_dir/casperjs.zip && mkdir $source_dir/casperjs && unzip $source_dir/casperjs.zip -d $source_dir && mv $source_dir/n1k0-casperjs-*/* $source_dir/casperjs/ && rm -rf $source_dir/n1k0-casperjs-*",
    creates => "$source_dir/casperjs/",
    require => Package['curl', 'unzip'],
  }

  file { "$install_dir/casperjs":
    ensure => link,
    target => "$source_dir/casperjs/bin/casperjs",
    force => true,
  }

  if $package_update {
    exec { 'remove casperjs':
      command => "/bin/rm -rf $source_dir/casperjs",
      notify => Exec[ 'get casperjs' ]
    }
  }
}
