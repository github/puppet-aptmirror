require 'spec_helper'

describe 'aptmirror' do
  expect_it { to contain_package('apt-mirror') }

  expect_it { to contain_file('/etc/apt/mirror.list') }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/base_path\s+\/var\/spool\/apt-mirror/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/mirror_path\s+\$base_path\/mirror/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/skel_path\s+\$base_path\/skel/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/var_path\s+\$base_path\/var/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/cleanscript\s+\$base_path\/clean\.sh/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').
    with_content(/postmirror_script\s+\$var_path\/postmirror.sh/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/defaultarch\s+amd64/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/run_postmirror\s+0/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/nthreads\s+20/)
  }
  expect_it {
    to contain_file('/etc/apt/mirror.list').with_content(/_tilde\s+0/)
  }

  context 'with an aptmirror::source' do
    let(:pre_condition) { <<-EOF
      aptmirror::source { 'http://us.archive.ubuntu.com':
        distributions => ['precise', 'precise-security'],
        components    => ['main', 'restricted'],
        clean         => true,
        amd64         => true,
        i386          => true,
        source        => true,
      }
      EOF
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/deb-src http:\/\/us\.archive\.ubuntu\.com precise main restricted/)
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/deb-src http:\/\/us\.archive\.ubuntu\.com precise-security main restricted/)
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/deb-amd64 http:\/\/us\.archive\.ubuntu\.com precise main restricted/)
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/deb-amd64 http:\/\/us\.archive\.ubuntu\.com precise-security main restricted/)
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/deb-i386 http:\/\/us\.archive\.ubuntu\.com precise main restricted/)
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/deb-i386 http:\/\/us\.archive\.ubuntu\.com precise-security main restricted/)
    }

    expect_it {
      to contain_file('/etc/apt/mirror.list').
      with_content(/clean http:\/\/us\.archive\.ubuntu\.com/)
    }
  end
end
