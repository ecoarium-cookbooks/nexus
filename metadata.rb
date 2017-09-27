name             'nexus'
maintainer       'Jay Flowers'
maintainer_email 'jay.flowers@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures nexus'
long_description 'nexus'
version          '1.1.1'

%w{ centos }.each do |os|
  supports os
end

depends 'chef_commons'
depends 'apache2'
depends 'selinux'
depends 'ark'
depends 'java'
