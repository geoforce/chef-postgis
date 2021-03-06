maintainer       "Kevin Berry"
maintainer_email "kevin@opensourcealchemist.com"
license          "Apache 2.0"
description      "Installs/Configures postgis"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

depends 'apt', '>= 1.4.8'
depends 'postgresql', '>= 0.99.4'

%w{ ubuntu debian }.each do |os|
  supports os
end
