# rubocop:disable Style/SingleSpaceBeforeFirstArg
name             "open_resty"
maintainer       "pseudomuto"
maintainer_email "david.muto@gmail.com"
license          "all_rights"
description      "Installs/Configures open_resty"
long_description "Installs/Configures open_resty"
version          "0.2.0"
# rubocop:enable Style/SingleSpaceBeforeFirstArg

supports "ubuntu"

chef_version ">= 12.5" if respond_to?(:chef_version)
source_url "https://github.com/pseudomuto/chef-open_resty" if respond_to?(:source_url)
issues_url "https://github.com/pseudomuto/chef-open_resty/isseus" if respond_to?(:issues_url)

depends "apt"
depends "ark"
depends "runit"
